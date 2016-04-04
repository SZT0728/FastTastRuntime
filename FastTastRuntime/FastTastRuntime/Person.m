//
//  Person.m
//  FastTastRuntime
//
//  Created by SZT on 16/4/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "Person.h"


@interface Person()<NSCoding>

@end

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
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        SEL aSel = @selector(drink);
        Method aMethod = class_getInstanceMethod(selfClass, aSel);
        SEL bSel = @selector(eat);
        Method bMethod = class_getInstanceMethod(selfClass, bSel);
        BOOL addSuc = class_addMethod(selfClass, aSel, method_getImplementation(bMethod), method_getTypeEncoding(bMethod));
        if (addSuc) {
            class_replaceMethod(selfClass, bSel, method_getImplementation(aMethod), method_getTypeEncoding(aMethod));
        }else{
            method_exchangeImplementations(bMethod, aMethod);
        }
        
    });
    
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


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int outCount;
        Ivar *ivarList = class_copyIvarList([Person class], &outCount);
        for (NSInteger i = 0; i < outCount; i ++) {
            Ivar ivar = ivarList[i];
            NSString *ivarName = [NSString
                                  stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:ivarName] forKey:ivarName];
        }
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount;
    Ivar *ivarlist = class_copyIvarList([self class], &outCount);
    for (NSInteger i = 0; i < outCount; i ++) {
        Ivar ivar = ivarlist[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:ivarName] forKey:ivarName];
    }
}

/**
 *  动态添加函数实现消息转发
 */

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selString = NSStringFromSelector(sel);
    if ([selString isEqualToString:@"goForWork"]) {
        /**
         *   为类中没有实现的方法添加一个函数实现
         *
         *  @param self      类名
         *  @param goForWork 没有实现的方法
         *  @IMP   workFunc  添加的函数实现
         *  @      "v@:"     TypeEncoding函数类型的类型编码
         *  @return
         */
        class_addMethod(self, @selector(goForWork), (IMP)workFunc, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

void workFunc(id self,SEL sel)
{
    NSLog(@"Person go for work");
}

/**
 *  转换消息接收者实现消息转发
 */
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    NSString *selString = NSStringFromSelector(aSelector);
    if ([selString isEqualToString:@"walk"]) {
        self.myDog = [Dog new];
        return self.myDog;
    }
    return [super forwardingTargetForSelector:aSelector];
}
 

/**
 *  转换消息接收者实现消息转发方式而二
 */

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [Dog instanceMethodSignatureForSelector:aSelector];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([Dog instancesRespondToSelector:anInvocation.selector]) {
        //消息调用
        [anInvocation invokeWithTarget:self.myDog];
        
    }
}


-(void)drink
{
    NSLog(@"我在喝水");
}
-(void)eat
{
    NSLog(@"我在吃东西");
}



@end
