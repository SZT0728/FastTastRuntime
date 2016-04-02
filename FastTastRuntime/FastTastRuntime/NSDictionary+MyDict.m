//
//  NSDictionary+MyDict.m
//  FastTastRuntime
//
//  Created by SZT on 16/4/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "NSDictionary+MyDict.h"

@implementation NSDictionary (MyDict)

-(void)setFunnyName:(NSString *)funnyName
{
    objc_setAssociatedObject(self, @selector(funnyName), funnyName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)funnyName
{
    return objc_getAssociatedObject(self, @selector(funnyName));
}

-(void)setDictAction:(void (^)(NSString *))dictAction
{
    objc_setAssociatedObject(self, @selector(dictAction), dictAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(NSString *))dictAction
{
    return objc_getAssociatedObject(self, @selector(dictAction));
}


@end
