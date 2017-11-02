//
//  DetailView.m
//  Bcollection
//
//  Created by 李嘉银 on 2017/11/2.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import "DetailView.h"

@interface DetailView ()

@end

@implementation DetailView
-(void)setUIwithItem{
    _backgroundimage.image=_item.image;
    _imageplace.image=_item.image;
    _namelabel.text=_item.name;
    _countrylabel.text=_item.country;
    _timelabel.text=[NSString stringWithFormat:@"上映于%@",_item.time];
    _capacitylabel.text=[NSString stringWithFormat:@"共%@集",_item.capacity];
}
-(id)initWithItem:(BiliItem *)item{
    NSInteger margin=40;
    self=[super init];
    self.item=item;
    _backgroundimage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _backgroundimage.clipsToBounds=YES;
    _backgroundimage.contentMode=UIViewContentModeScaleAspectFill;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview: _backgroundimage];
    [self.view addSubview:effectView];
    _imageplace =[[UIImageView alloc]initWithFrame:CGRectMake(margin, 64+margin, [UIScreen mainScreen].bounds.size.width-2*margin, ([UIScreen mainScreen].bounds.size.width-2*margin)*0.75)];
    _imageplace.clipsToBounds=YES;
    _imageplace.contentMode=UIViewContentModeScaleAspectFill;
    _namelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+margin+_imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    _namelabel.textAlignment=NSTextAlignmentCenter;
    _namelabel.font=[UIFont systemFontOfSize:30 weight:UIFontWeightHeavy];
    [self.view addSubview:_imageplace];
    [self.view addSubview:_namelabel];
    _countrylabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+2*margin+_imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    _timelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+3*margin+_imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    _capacitylabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+4*margin+_imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    _countrylabel.textAlignment=NSTextAlignmentCenter;
    _timelabel.textAlignment=NSTextAlignmentCenter;
    _capacitylabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_countrylabel];
    [self.view addSubview:_timelabel];
    [self.view addSubview:_capacitylabel];
    [self setUIwithItem];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarButton];
    // Do any additional setup after loading the view.
}
-(void)setNaviBarButton{
    UIBarButtonItem * likebutton=[[UIBarButtonItem alloc] initWithTitle:self.item.like?@"❤️":@"🖤" style:UIBarButtonItemStyleDone target:self action:@selector(likeAction)];
    UIBarButtonItem * editbutton=[[UIBarButtonItem alloc] initWithTitle:@"✏️" style:UIBarButtonItemStyleDone target:self action:@selector(editAction)];
    UIBarButtonItem * savebutton=[[UIBarButtonItem alloc] initWithTitle:@"💾" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:editbutton,likebutton,savebutton, nil];
}
-(void)likeAction{
    self.item.like=!self.item.like;
    [self setNaviBarButton];
}
-(void)editAction{
    AddItemPage * editpage=[[AddItemPage alloc]initWithItem:self.item];
    editpage.itemsetter = ^(BiliItem *item) {
        self.item=item;
        [self setUIwithItem];
        [self.navigationController  popViewControllerAnimated:YES ];
        [self.view layoutSubviews];
    };
    [self.navigationController pushViewController:editpage animated:YES];
}

-(void)saveAction{
    self.itemsetter(self.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
