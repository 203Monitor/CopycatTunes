//
//  Download.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/18.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "Track+Download.h"

@implementation Track (Download)

- (void)downloadFromServer{
    
    //远程地址
    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    URL = self.audioFileURL;
    
    if ([URL.description hasPrefix:@"file"]) {
        return;
    }
    
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    WS(weakSelf);
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置进度条的百分比
            float progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            NSLog(@"%f",progress);
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSArray *suffix = [response.suggestedFilename componentsSeparatedByString:@"."];
        
        NSString *path = [cachesPath stringByAppendingPathComponent:[[weakSelf.trackId stringByAppendingString:@"."] stringByAppendingString:[suffix lastObject]]];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        NSString *getfilePath = [filePath path];// 将NSURL转成NSString
        NSLog(@"%@",getfilePath);
        [DBOperation insertWithTrack:weakSelf];
    }];
    
    [downloadTask resume];
}

- (void)removeLocalDocument {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *realFilePath = [[[MUSICCACHEROOT stringByAppendingString:@"/"] stringByAppendingString:self.trackId] stringByAppendingString:@".m4a"];
    BOOL isDelete=[fileManager removeItemAtPath:realFilePath error:nil];
    NSLog(@"%d",isDelete);
}

@end
