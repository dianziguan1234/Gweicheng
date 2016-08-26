//
//  NSTimer+Eazy.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/29.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Eazy)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
