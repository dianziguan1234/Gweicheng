//
//  NSObject+GCD.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  可取消异步调用回调
 */
@protocol NBCancelable <NSObject>

/**
 *  取消回调
 */
- (void)nb_cancel;

@end
/**
 *  主要替换如下过程：
 dispatch_async(dispatch_get_main_queue(), ^{
 //todo
 });
 
 这种方式在某种情况下存在风险，如果一个底层系统回调到主线程时，千万不要随意使用上面的方式
 这是一种不可预测的写法，可能造成main_queue阻断，如果block中又嵌套的runloop，
 将造成后续的block无法执行
 */
@interface NSObject (GCD)

/**
 *  到主线程中同步执行block
 *
 *  @param block 执行的block
 */
- (void)nb_mainThreadSyncBlock:(dispatch_block_t)block;

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
- (void)nb_mainThreadAsyncBlock:(dispatch_block_t)block;

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
- (id<NBCancelable>)nb_handlerMainThreadAsyncBlock:(dispatch_block_t)block;

/**
 *  到主线程中延迟执行block
 *
 *  @param after 延后时间
 *  @param block 执行的block
 */
- (void)nb_mainThreadAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

/**
 *  到主线程中同步执行block
 *
 *  @param block 执行的block
 */
+ (void)nb_mainThreadSyncBlock:(dispatch_block_t)block;

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
+ (void)nb_mainThreadAsyncBlock:(dispatch_block_t)block;

/**
 *  到主线程中异步执行block
 *
 *  @param block 执行的block
 */
+ (id<NBCancelable>)nb_handlerMainThreadAsyncBlock:(dispatch_block_t)block;

/**
 *  到主线程中延迟执行block
 *
 *  @param after 延后时间
 *  @param block 执行的block
 */
+ (void)nb_mainThreadAfter:(NSTimeInterval)after block:(dispatch_block_t)block;

@end

@interface NBCancelable : NSObject <NBCancelable>
@property (nonatomic,weak) id target;
@property (nonatomic,copy) dispatch_block_t block;
@end
