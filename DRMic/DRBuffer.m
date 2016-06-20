//
//  DRBuffer.m
//  DRMic
//
//  Created by Darry on 16/6/20.
//  Copyright © 2016年 Darry. All rights reserved.
//

#import "DRBuffer.h"

@interface DRBuffer()
{
    NSDecimalNumber *adjustedData;
}
@property (nonatomic,strong)NSMutableArray *buffer;

@end
@implementation DRBuffer
static int divider = 0;
- (float)adjustData:(float)lastData
{
    [self queueInNewData:[self convertToDecimal:lastData]];
    adjustedData = [self averageNum];
    return adjustedData.floatValue;
}

- (NSMutableArray *)buffer
{
    if (!_buffer) {
        _buffer = [NSMutableArray arrayWithCapacity:kBufferCapacity];
        for (int i = 0; i < kBufferCapacity; i++) {
            [_buffer addObject:[[NSDecimalNumber alloc] initWithString:@"0.0"]];
        }
    }
    return _buffer;
}

- (void)queueInNewData:(NSDecimalNumber*)lastData
{
    [_buffer removeObjectAtIndex:0];
    [_buffer insertObject:lastData atIndex:(kBufferCapacity-1)];
}

- (NSDecimalNumber*)averageNum
{
    float averageNum = 0.0;
    for (int i = 0; i < kBufferCapacity; i++) {
        averageNum += ((NSDecimalNumber *)self.buffer[i]).floatValue;
    }
    
    if (divider < kBufferCapacity) {
        divider ++;
    }else {
        divider = kBufferCapacity;
    }
    
    averageNum = averageNum / divider;
    
    return [self convertToDecimal:averageNum];
}

- (NSDecimalNumber*)convertToDecimal:(float)floatNum
{
    return [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f",floatNum]];
}

@end
