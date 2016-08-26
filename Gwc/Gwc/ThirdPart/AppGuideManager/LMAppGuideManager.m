//
//  LMAppGuideManager.m
//  LawMonkey
//
//  Created by 刘彬 on 16/8/22.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "LMAppGuideManager.h"

@implementation LMAppGuideManager

+ (void)guideWithKey:(NSString *)key ignoreAppVersion:(BOOL)ignoreVersion shouldGuideBlock:(void (^)(void))shouldGuideBlock dontGuideBlock:(void (^)(void))dontGuideBlock {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    // 用版本号做value来比较
    NSString *lastVersion = [userDefault objectForKey:key];
    // 当前的版本号
    NSString *currentVersion = [UIApplication appVersion];
    BOOL needGuide = YES;
    if (ignoreVersion) { // 忽略版本号（只出现一次）
        needGuide = [NSString nb_isEmpty:lastVersion];
    } else{ // 需要比较版本号（每个新版本都出现）
        needGuide = [currentVersion nb_compareAppVersion:lastVersion] == NSOrderedDescending;
    }
    if (needGuide) {
        if (shouldGuideBlock) {
            shouldGuideBlock();
        }
        [userDefault setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        if (dontGuideBlock) {
            dontGuideBlock();
        }
    }
}

+ (void)resetWithKey:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:nil forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
