//
//  NBBaseListModel.h
//  LawMonkey
//
//  Created by 刘彬 on 16/4/12.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBBaseModel.h"

/*!
 *  @brief  分页数据model
 */
@interface NBBaseListModel : NBBaseModel

/*!
 *  @brief  数据源
 */
@property (nonatomic, strong) NSMutableArray *items;

/*!
 *  @brief  页尺寸
 */
@property (nonatomic, assign) NSInteger      pageSize;

/*!
 *  @brief  当前页码
 */
@property (nonatomic, assign) NSInteger      pageNum;

/*!
 *  @brief  是否有更多
 */
@property (nonatomic, assign) BOOL           hasMore;

/*!
 *  @brief  当前页面数据数量
 */
@property (nonatomic, assign) NSInteger      currentSize;

/*!
 *  @brief  总数量
 */
@property (nonatomic, assign) NSInteger      totalRecords;


- (id)initWithArray:(NSArray*)array;
- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)object;
- (void)removeAllObjects;



@end
