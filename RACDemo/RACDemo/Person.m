//
//  RAC_01______Tests.m
//  RAC-01-联系人列表Tests
//
//  Created by 姜超 on 16/3/24.
//  Copyright © 2016年 jiangchao. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
    NSArray *keys = @[@"name", @"age"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
