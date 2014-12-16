//
//  NdUncaughtExceptionHandler.h
//  Search
//
//  Created by h on 14-12-9.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NdUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;

+ (NSUncaughtExceptionHandler*)getHandler;

@end
