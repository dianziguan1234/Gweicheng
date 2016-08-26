//
//  NBBaseViewModel.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NBBaseViewModelDelegate;

/*!
 @class
 @abstract      基础数据构造器，由子类实现相关的构造逻辑
 */
@interface NBBaseViewModel : NSObject {
    BOOL _isLoading;
}

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, weak) id responder;
@property (nonatomic, weak) id<NBBaseViewModelDelegate>delegate;
@property (nonatomic, assign, readonly) BOOL isLoading;

/*!
 *  @brief  加载数据，子类重写
 */
- (void)loadData;

/*!
 *  @brief  重新加载数据，子类重写
 */
- (void)reloadData;

/*!
 *  @brief  构建数据，子类重写
 */
- (void)constructData;

/*!
 *  @brief  数据构建完成通知view，子类继承
 *
 *  @param dataModel datamodel
 *  @param error     错误信息
 */
- (void)didFinishLoadData:(id)dataModel error:(NSError *)error;

@end

@protocol NBBaseViewModelDelegate <NSObject>

@optional
- (void)viewModel:(NBBaseViewModel *)viewModel
  didFinishLoadWithData:(id)dataModel
                  error:(NSError *)error;
@end

