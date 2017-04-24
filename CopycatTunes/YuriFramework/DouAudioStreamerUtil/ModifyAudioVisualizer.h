//
//  DOUAudioVisualizer.h
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/14.
//  Copyright © 2017年 武国斌. All rights reserved.
//


#if TARGET_OS_IPHONE

#import "DOUAudioVisualizer.h"

@interface ModifyAudioVisualizer : DOUEAGLView

@property (nonatomic, assign) NSUInteger stepCount;
@property (nonatomic, assign) DOUAudioVisualizerInterpolationType interpolationType;

@end

#endif /* TARGET_OS_IPHONE */
