//
//  BiliCell.m
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import "BiliCell.h"

@implementation BiliCell
-(void)setCellWithItem:(BiliItem*)item{
    for (UIView *subview in [self.contentView subviews]) {
        [subview removeFromSuperview];
    }
    self.backgroundColor=[UIColor whiteColor];
    UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*3/4)];
    imageview.image=item.image;
    imageview.contentMode=UIViewContentModeScaleAspectFill;
    imageview.layer.masksToBounds=YES;
    UILabel * namelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imageview.frame.size.height+2, self.frame.size.width,self.frame.size.height/8)];
    UILabel * timelabel=[[UILabel alloc]initWithFrame:CGRectMake(5, imageview.frame.size.height+4+namelabel.frame.size.height, self.frame.size.width/2,self.frame.size.height/8)];
    UILabel * capacitylabel=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-5, imageview.frame.size.height+4+namelabel.frame.size.height, self.frame.size.width/2,self.frame.size.height/8)];
    namelabel.text=item.name;
    timelabel.text=item.time;
    capacitylabel.text=[item.capacity stringByAppendingString:@"集"];
    namelabel.textAlignment=NSTextAlignmentCenter;
    namelabel.font=[UIFont systemFontOfSize:25 weight:UIFontWeightHeavy];
    timelabel.font=[UIFont systemFontOfSize:13];
    timelabel.textColor=[UIColor darkGrayColor];
    capacitylabel.textColor=[UIColor darkGrayColor];
    capacitylabel.font=[UIFont systemFontOfSize:13];
    capacitylabel.textAlignment=NSTextAlignmentRight;
    self.deleteButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.deleteButton setTitle:@"❌" forState:0];
    self.deleteButton.frame =CGRectMake(-5, -5, 30, 30);
    self.deleteButton.hidden=NO;
    self.deleteButton.enabled=NO;
    self.deleteButton.alpha=0;
    [self.deleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    self.contentView.userInteractionEnabled=YES;
    [self.contentView addSubview:imageview];
    [self.contentView addSubview:namelabel];
    [self.contentView addSubview:timelabel];
    [self.contentView addSubview:capacitylabel];
    [self.contentView addSubview:self.deleteButton];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
-(void)DeleteAction{
    NSLog(@"%lu",self.deleteButton.tag);
    self.deleteCell(self.deleteButton.tag);
}
@end
