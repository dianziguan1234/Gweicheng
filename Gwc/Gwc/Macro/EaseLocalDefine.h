//
//  EaseLocalMarco.h
//  Gwc
//
//  Created by apple on 8/26/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#ifndef EaseLocalMarco_h
#define EaseLocalMarco_h

#define NSEaseLocalizedString(key, comment) [[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"EaseUIResource" withExtension:@"bundle"]] localizedStringForKey:(key) value:@"" table:nil]

#endif /* EaseLocalMarco_h */
