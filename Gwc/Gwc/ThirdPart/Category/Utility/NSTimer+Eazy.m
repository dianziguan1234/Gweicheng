//
//  NSTimer+Eazy.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/29.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NSTimer+Eazy.h"

@implementation NSTimer (Eazy)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
