//
//  HomeController.h
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiliCell.h"
#import "BiliItem.h"
#import "AddItemPage.h"
#import "DetailView.h"
@interface HomeController : UICollectionViewController<UICollectionViewDataSource,UINavigationControllerDelegate>
@property(strong,nonatomic) NSString * archiverPath;
@end
