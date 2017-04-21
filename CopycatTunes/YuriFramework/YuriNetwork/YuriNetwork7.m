//
//  YuriNetwork7.m
//  Request
//
//  Created by 武国斌 on 2017/4/8.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "YuriNetwork7.h"
#import "NSDictionary+ToData.h"

@implementation YuriNetwork7

- (void)requestWithURL:(NSString *)url andMethod:(NSString *)method andParams:(NSDictionary *)params andSucceed:(void (^)(NSDictionary *dictionary))succeed andFailure:(void (^)(NSError *error))failure {
    
    NSData *postData = [params toData];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:method];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    /**
     
     NSURLSessionConfiguration
     
     1.默认会话模式（default）：工作模式类似于原来的NSURLConnection，使用的是基于磁盘缓存的持久化策略，使用用户keychain中保存的证书进行认证授权。
     + (NSURLSessionConfiguration *)defaultSessionConfiguration;
     
     
     2.瞬时会话模式（ephemeral）：该模式不使用磁盘保存任何数据。所有和会话相关的caches，证书，cookies等都被保存在RAM中，因此当程序使会话无效，这些缓存的数据就会被自动清空。
     + (NSURLSessionConfiguration *)ephemeralSessionConfiguration;
     
     
     3.后台会话模式（background）：该模式在后台完成上传和下载，在创建Configuration对象的时候需要提供一个NSString类型的ID用于标识完成工作的后台会话。
     + (NSURLSessionConfiguration *)backgroundSessionConfigurationWithIdentifier:(NSString *)identifier;
     
     @property BOOL allowsCellularAccess;
     @property (getter=isDiscretionary) BOOL discretionary;
     allowsCellularAccess属性指定是否允许使用蜂窝连接，discretionary属性为YES时表示当程序在后台运作时由系统自己选择最佳的网络连接配置，该属性可以节省通过蜂窝连接的带宽。在使用后台传输数据的时候，建议使用discretionary属性，而不是allowsCellularAccess属性，因为它会把WiFi和电源可用性考虑在内。
     补充：这个标志允许系统为分配任务进行性能优化。这意味着只有当设备有足够电量时，设备才通过Wifi进行数据传输。如果电量低，或者只仅有一个蜂窝连接，传输任务是不会运行的。后台传输总是在discretionary模式下运行。
     */
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    //配置请求头
    [config setHTTPAdditionalHeaders:@{@"key":@"value"}];
    
    /**
     
     NSURLSession
     
     1.使用静态的sharedSession方法，该类使用共享的会话，该会话使用全局的Cache，Cookie和证书。
     + (NSURLSession *)sharedSession;
     
     2.通过sessionWithConfiguration:方法创建对象，也就是创建对应配置的会话，与NSURLSessionConfiguration合作使用。
     + (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration;
     
     3.通过sessionWithConfiguration:delegate:delegateQueue方法创建对象，后两种方式可以创建一个新会话并定制其会话类型。
     该方式中指定了session的委托和委托所处的队列。当不再需要连接时，可以调用Session的invalidateAndCancel直接关闭，或者调用finishTasksAndInvalidate等待当前Task结束后关闭。这时Delegate会收到URLSession:didBecomeInvalidWithError:这个事件。Delegate收到这个事件之后会被解引用。
     + (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue;
     */
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    /**
     
     NSURLSessionTask
     
     NSURLSessionTask是一个抽象子类，它有三个子类：NSURLSessionDataTask，NSURLSessionUploadTask和NSURLSessionDownloadTask。
     这三个类封装了现代应用程序的三个基本网络任务：获取数据，比如JSON或XML，以及上传和下载文件。
     
     * NSURLSessionDataTask *
     - (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request;
     - (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url;
     
     * 带有结束block *
     - (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)())completionHandler;
     - (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)())completionHandler;
     
     * NSURLSessionUploadTask *
     - (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL;
     - (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData;
     - (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request;
     
     * 带有结束block *
     - (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)())completionHandler;
     - (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData completionHandler:(void (^)())completionHandler;
     
     * NSURLSessionDownloadTask *
     - (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request;
     - (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url;
     - (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData;
     
     * 带有结束block *
     - (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)())completionHandler;
     - (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)())completionHandler;
     - (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)())completionHandler;
     */
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        //拿到响应头信息
//        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        
        if (error) {
            failure(error);
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                succeed(dic);
            });
        }
    }];
    
    //3.执行Task
    //注意：刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
    [dataTask resume];
}

@end
