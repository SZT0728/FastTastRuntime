//
//  Person.h
//  FastTastRuntime
//
//  Created by SZT on 16/4/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Dog.h"

@interface Person : NSObject
{
    NSString *clan;//族名
}
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,strong)NSNumber *age;
@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)double weight;

@property(nonatomic,strong)Dog *myDog;

+ (Person *)personWithName:(NSString *)name age:(NSNumber *)age gender:(NSString *)gender clan:(NSString *)clan;

- (void)personGetPersonMessage;

- (void)getAttributeOfproperty;

- (void)goForWork;

- (void)walk;


//方法交换测试
- (void)drink;

- (void)eat;


@end
