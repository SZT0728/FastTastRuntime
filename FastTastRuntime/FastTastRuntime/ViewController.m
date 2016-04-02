//
//  ViewController.m
//  FastTastRuntime
//
//  Created by SZT on 16/4/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSDictionary+MyDict.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [Person personWithName:@"张三" age:@26 gender:@"man" clan:@"汉"];
    [person description];
    [person personGetPersonMessage];
    [person getAttributeOfproperty];
    
    NSDictionary *dict = [NSDictionary new];
    dict.funnyName = @"SoFunny";
    NSLog(@"dict.funnyName = %@",dict.funnyName);
    void(^action)(NSString *str)  = ^(NSString *str){
        NSLog(@"打印了这个字符串:%@",str);
    };
    //设置block
    dict.dictAction = action;
    
    //调用dict的action
    dict.dictAction(@"新增加变量dicAction");
    
    


}

@end
