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
-(id)initWithItem:(BiliItem *)item{
    NSInteger margin=40;
    self=[super init];
    self.item=item;
    UIImageView * backgroundimage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundimage.image=item.image;
    backgroundimage.clipsToBounds=YES;
    backgroundimage.contentMode=UIViewContentModeScaleAspectFill;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview: backgroundimage];
    [self.view addSubview:effectView];
    UIImageView * imageplace =[[UIImageView alloc]initWithFrame:CGRectMake(margin, 64+margin, [UIScreen mainScreen].bounds.size.width-2*margin, ([UIScreen mainScreen].bounds.size.width-2*margin)*0.75)];
    imageplace.image=item.image;
    imageplace.clipsToBounds=YES;
    imageplace.contentMode=UIViewContentModeScaleAspectFill;
    UILabel * namelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+margin+imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    namelabel.text=item.name;
    namelabel.textAlignment=NSTextAlignmentCenter;
    namelabel.font=[UIFont systemFontOfSize:30 weight:UIFontWeightHeavy];
    [self.view addSubview:imageplace];
    [self.view addSubview:namelabel];
    UILabel * countrylabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+2*margin+imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    UILabel * timelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+3*margin+imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    UILabel * capacitylabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+4*margin+imageplace.frame.size.height,self.view.frame.size.width, self.view.frame.size.height/8)];
    countrylabel.text=item.country;
    timelabel.text=[NSString stringWithFormat:@"上映于%@",item.time];
    capacitylabel.text=[NSString stringWithFormat:@"共%@集",item.capacity];
    countrylabel.textAlignment=NSTextAlignmentCenter;
    timelabel.textAlignment=NSTextAlignmentCenter;
    capacitylabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:countrylabel];
    [self.view addSubview:timelabel];
    [self.view addSubview:capacitylabel];
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
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:editbutton,likebutton, nil];
}
-(void)likeAction{
    self.item.like=!self.item.like;
    [self setNaviBarButton];
}
-(void)editAction{
    
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
