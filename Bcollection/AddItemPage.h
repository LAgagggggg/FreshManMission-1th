//
//  AddItemPage.h
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiliItem.h"

@interface AddItemPage : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property(strong,nonatomic)UIView* imageplace;
@property(strong,nonatomic)BiliItem * item;
@property(strong,nonatomic)UITextField* nameinput;
@property(strong,nonatomic)UITextField* timeinput;
@property(strong,nonatomic)UITextField* countryinput;
@property(strong,nonatomic)UITextField* capacityinput;
@property BOOL lock;
@property CGFloat keyboardheight;
@property(strong,nonatomic)void(^itemsetter)(BiliItem * item);
@end
