//
//  Person.m
//  FastTastRuntime
//
//  Created by SZT on 16/4/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "Person.h"

@implementation Person


+ (Person *)personWithName:(NSString *)name age:(NSNumber *)age gender:(NSString *)gender clan:(NSString *)clan
{
    Person *p = [Person new];
    unsigned int outCount;
    Ivar *IvarArray = class_copyIvarList([Person class], &outCount);
    object_setIvar(p, IvarArray[0], clan);
    object_setIvar(p, IvarArray[1], name);
    object_setIvar(p, IvarArray[2], gender);
    object_setIvar(p, IvarArray[3], age);
    return p;
}

- (void)personGetPersonMessage
{
    unsigned int outCount;
    Ivar *IvarArray = class_copyIvarList([Person class], &outCount);
    for (NSInteger i = 0; i < 4; i ++) {
        NSLog(@"%s = %@",ivar_getName(IvarArray[i]),object_getIvar(self,IvarArray[i]));
    }
}

-(NSString *)description
{
    unsigned int outCount;
    Ivar *IvarArray = class_copyIvarList([Person class], &outCount);//获取到Person中的所有成员变量
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar *ivar = &IvarArray[i];
        NSLog(@"第%d个成员变量:%s,类型是:%s",i,ivar_getName(*ivar),ivar_getTypeEncoding(*ivar));// 依次获取每个成员变量并且打印成员变量名字和类型
    }
    return nil;
}

- (void)getAttributeOfproperty
{
    unsigned int outCount;
    objc_property_t *propertyList = class_copyPropertyList([Person class], &outCount);
    for (NSInteger i = 0; i < outCount; i ++) {
        NSLog(@"属性：%s,它的特性描述:%s",property_getName(propertyList[i]),property_getAttributes(propertyList[i]));
    //属性的名字和特性获取也可以通过objc_property_t具有的属性（name，value）访问到
        /**
         *  objc_property_t *property;
            property.name =  属性名称
            property.value = 属性特性
         */
    }
}








@end
