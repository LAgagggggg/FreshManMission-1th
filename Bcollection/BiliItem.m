//
//  BiliItem.m
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import "BiliItem.h"

@implementation BiliItem
-(BiliItem *)SetBiliItemWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}
@end
