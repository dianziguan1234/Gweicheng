//
//  Person.h
//  Gwc
//
//  Created by apple on 9/1/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {

    NSString *_name;
}
@property(nonatomic ,copy)NSString *name;
- (void)run;

@end
