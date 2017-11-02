//
//  DetailView.h
//  Bcollection
//
//  Created by 李嘉银 on 2017/11/2.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiliItem.h"
#import "AddItemPage.h"

@interface DetailView : UIViewController<UINavigationControllerDelegate>
@property(strong,nonatomic)BiliItem * item;
@property(strong,nonatomic)UILabel * namelabel;
@property(strong,nonatomic)UILabel * timelabel;
@property(strong,nonatomic)UILabel * countrylabel;
@property(strong,nonatomic)UILabel * capacitylabel;
@property(strong,nonatomic)UIImageView * imageplace;
@property(strong,nonatomic)UIImageView * backgroundimage;
@property(strong,nonatomic)void(^itemsetter)(BiliItem * item);
-initWithItem:(BiliItem *)item;
@end
