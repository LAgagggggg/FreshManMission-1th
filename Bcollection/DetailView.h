//
//  DetailView.h
//  Bcollection
//
//  Created by 李嘉银 on 2017/11/2.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiliItem.h"

@interface DetailView : UIViewController
@property(strong,nonatomic)BiliItem * item;
-initWithItem:(BiliItem *)item;
@end
