//
//  DRBuffer.h
//  DRMic
//
//  Created by Darry on 16/6/20.
//  Copyright © 2016年 Darry. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPerSecond 0.1 /* 采集频率基数**/
#define kBufferCapacity 50 /* 缓存平均个数: 数值越小越敏感, 数值越大惯性越大**/

@interface DRBuffer : NSObject

- (float)adjustData:(float)lastData;

@end
