//
//  NSDictionary+MyDict.h
//  FastTastRuntime
//
//  Created by SZT on 16/4/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSDictionary (MyDict)

@property(nonatomic,copy)NSString *funnyName;
@property(nonatomic,copy)void(^dictAction)(NSString *str);

@end
