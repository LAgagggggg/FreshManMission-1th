//
//  BiliItem.h
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BiliItem : NSObject<NSCoding>
//主界面的每个番剧条目应至少包括番剧名／上映时间／集数，点击每个番剧条目可以进入详情页面，点击追番按钮进入追番界面，查看番剧情况，并对其进行管理
//在详情页面，要求显示番剧的 番剧名／上映时间／国家／集数／预览图，并可以选择添加到追番列表
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * time;
@property(strong,nonatomic)NSString * country;
@property(strong,nonatomic)NSString * capacity;
@property(strong,nonatomic)UIImage * image;
@property BOOL * like;

-(instancetype)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
//-(BiliItem *)SetBiliItemWithDict:(NSDictionary*)dict;
//-(NSDictionary *)MakeDictWithItem:(BiliItem *)item;
@end
