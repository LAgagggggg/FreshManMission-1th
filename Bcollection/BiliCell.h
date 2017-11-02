//
//  BiliCell.h
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiliItem.h"

@interface BiliCell : UICollectionViewCell
@property(strong,nonatomic)UIButton * deleteButton;
@property(strong,nonatomic)void(^deleteCell)(NSInteger index);

-(void)setCellWithItem:(BiliItem*)item;
@end
