//
//  GlobalConfigMacro.h
//  Gwc
//
//  Created by apple on 8/26/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#ifndef GlobalConfigMacro_h
#define GlobalConfigMacro_h
//强引用弱引用
#define nbweak(s) __weak typeof(s) w_self                 = (s)
#define nbstrong(s) __strong typeof(w_self) (s)           = w_self
#define lmweak(weakSelf)  __weak __typeof(&*self)weakSelf = self

// 生产环境/测试环境
#if LM_API_HOST == 0

#define kBaseUrl        @"http://120.26.199.0:666/api/"
#define kClientVersion  @"1.0.0.i_rel"

// 测试环境
#elif LM_API_HOST == 1

#define kBaseUrl        @"http://121.196.226.223:666/api/"
#define kClientVersion  @"1.0.0.i_dev"

// 默认为生产环境
#else

#define kBaseUrl        @"http://120.26.199.0:666/api/"
#define kClientVersion  @"1.0.0.i_rel"

#endif
#endif /* GlobalConfigMacro_h */
