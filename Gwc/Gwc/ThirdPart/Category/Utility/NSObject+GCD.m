//
//  NSObject+GCD.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NSObject+GCD.h"

@implementation NSObject (GCD)

- (void)nb_execute_block:(dispatch_block_t)block {
    block();
}

- (void)nb_execute_cancelable_block:(NBCancelable *)cancelable {
    if (cancelable.block) {
        cancelable.block();
    }
}

+ (void)nb_execute_block:(dispatch_block_t)block {
    block();
}

+ (void)nb_execute_cancelable_block:(NBCancelable *)cancelable {
    if (cancelable.block) {
        cancelable.block();
    }
}

/**
 *  到主线程中同步执行block
 *
 *  @param block 执行的block
 */
- (void)nb_mainThreadSyncBlock:(dispatch_block_t)block {
    if (block) {
        [self performSelectorOnMainThread:@selector(nb_execute_block:) withObject:block waitUntilDone:YES];
    }
}

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
- (void)nb_mainThreadAsyncBlock:(dispatch_block_t)block {
    if (block) {
        [self performSelectorOnMainThread:@selector(nb_execute_block:) withObject:block waitUntilDone:NO];
    }
}

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
- (id<NBCancelable>)nb_handlerMainThreadAsyncBlock:(dispatch_block_t)block {
    if (!block) {
        return nil;
    }
    
    NBCancelable *obj = [[NBCancelable alloc] init];
    obj.block = block;
    obj.target = self;
    [self performSelectorOnMainThread:@selector(nb_execute_cancelable_block:) withObject:obj waitUntilDone:NO];
    return obj;
}

/**
 *  到主线程中延迟执行block
 *
 *  @param block 执行的block
 */
- (void)nb_mainThreadAfter:(NSTimeInterval)after block:(dispatch_block_t)block {
    if (block) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
    }
}

/**
 *  到主线程中同步执行block
 *
 *  @param block 执行的block
 */
+ (void)nb_mainThreadSyncBlock:(dispatch_block_t)block {
    if (block) {
        [self performSelectorOnMainThread:@selector(nb_execute_block:) withObject:block waitUntilDone:YES];
    }
}

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
+ (void)nb_mainThreadAsyncBlock:(dispatch_block_t)block {
    if (block) {
        [self performSelectorOnMainThread:@selector(nb_execute_block:) withObject:block waitUntilDone:NO];
    }
}

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
+ (id<NBCancelable>)nb_handlerMainThreadAsyncBlock:(dispatch_block_t)block {
    if (!block) {
        return nil;
    }
    
    NBCancelable *obj = [[NBCancelable alloc] init];
    obj.block = block;
    obj.target = self;
    [self performSelectorOnMainThread:@selector(nb_execute_cancelable_block:) withObject:obj waitUntilDone:NO];
    return obj;
}

/**
 *  到主线程中延迟执行block
 *
 *  @param block 执行的block
 */
+ (void)nb_mainThreadAfter:(NSTimeInterval)after block:(dispatch_block_t)block {
    if (block) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
    }
}

@end

@implementation NBCancelable

- (void)nb_cancel {
    self.block = nil;
    
    id atarget = self.target;
    if (atarget) {
        [NSObject cancelPreviousPerformRequestsWithTarget:atarget selector:@selector(nb_execute_cancelable_block:) object:self];
    }
}

@end
