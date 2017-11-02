//
//  BiliItem.m
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import "BiliItem.h"

@implementation BiliItem
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.time = [aDecoder decodeObjectForKey:@"time"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    self.country = [aDecoder decodeObjectForKey:@"country"];
    self.capacity = [aDecoder decodeObjectForKey:@"capacity"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.time forKey:@"time"];
    [coder encodeObject:self.image forKey:@"image"];
    [coder encodeObject:self.country forKey:@"country"];
    [coder encodeObject:self.capacity forKey:@"capacity"];
}
//-(BiliItem *)SetBiliItemWithDict:(NSDictionary *)dict{
//    [self setValuesForKeysWithDictionary:dict];
//    return self;
//}
//-(NSDictionary *)MakeDictWithItem:(BiliItem *)item{
//    NSDictionary * dict =[[NSDictionary alloc]init];
//    [dict setValue:item.name forKey:@"name"];
//    [dict setValue:item.time forKey:@"time"];
//    [dict setValue:item.country forKey:@"country"];
//    [dict setValue:item.capacity forKey:(@"capacity")];
//    return dict;
//}
@end
