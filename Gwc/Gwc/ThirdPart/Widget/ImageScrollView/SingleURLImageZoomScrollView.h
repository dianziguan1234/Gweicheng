//
//  SingleURLImageZoomScrollView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/5/14.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SingleURLImageZoomScrollViewDelegate<NSObject>
- (void) browseEnd;
@end

@interface SingleURLImageZoomScrollView : UIScrollView
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) id<SingleURLImageZoomScrollViewDelegate> sigleImageDelegate;
- (void) zoomBack;

@end
