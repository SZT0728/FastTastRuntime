//
//  ViewController.m
//  FastTastRuntime
//
//  Created by SZT on 16/4/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [Person personWithName:@"张三" age:@26 gender:@"man" clan:@"汉"];
//    [person description];
//    [person personGetPersonMessage];
    [person getAttributeOfproperty];

}

@end
