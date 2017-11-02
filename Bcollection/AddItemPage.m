//
//  AddItemPage.m
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import "AddItemPage.h"

@interface AddItemPage ()


@end

@implementation AddItemPage
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    for(UITextField *subview in self.view.subviews)
    {
            [subview resignFirstResponder];
    }
}

-(void)keyBoardFrameChange:(NSNotification *)userInfo{
    if (_lock==0) {
        return;
    }
    NSDictionary * keyboardDict=userInfo.userInfo;
    CGRect frame=[keyboardDict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    _keyboardheight=frame.size.height;
    NSLog(@"%f",frame.size.height);
    [self setCorrectHeight];
}

-(void)setCorrectHeight{
    if (_lock==0) {
        return;
    }
    for(UITextField *subview in self.view.subviews)
    {
        if ([subview isFirstResponder]) {
            CGRect frame = self.view.frame;
            CGFloat change=([UIScreen mainScreen].bounds.size.height-subview.frame.origin.y-subview.frame.size.height)-self.keyboardheight;
            NSLog(@"%f",change);
            if (change<0) {
                frame.origin.y+=change;
                [UIView animateWithDuration:0.1 animations:^{
                    self.view.frame=frame;
                }];
                _lock=0;
            }
        }
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    CGRect frame = self.view.frame;
    CGFloat change=([UIScreen mainScreen].bounds.size.height-textField.frame.origin.y-textField.frame.size.height)-self.keyboardheight;
    NSLog(@"%f",change);
    if (change<0) {
        frame.origin.y-=change;
        [UIView animateWithDuration:0.1 animations:^{
            self.view.frame=frame;
        }];
    }
    _lock=1;
    return YES;
}

-(instancetype)initWithItem:(BiliItem *)item{
    self=[self init];
    self.item=item;
    UIImageView * newimageplace=[[UIImageView alloc]initWithFrame:self.imageplace.frame];
    CGRect frame=CGRectMake(0, 0, _imageplace.frame.size.width,_imageplace.frame.size.height);
    newimageplace.frame=frame;
    newimageplace.image=item.image;
    newimageplace.layer.masksToBounds=YES;
    newimageplace.contentMode=UIViewContentModeScaleAspectFill;
    [self.imageplace addSubview:newimageplace];
    self.nameinput.text=item.name;
    self.timeinput.text=item.time;
    self.countryinput.text=item.country;
    self.capacityinput.text=item.capacity;
    return self;
}

-(instancetype)init{
    self=[super init];
    _lock=1;
    self.item=[[BiliItem alloc]init];
    self.title=@"添加";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:0 target:self action:@selector(DoneWithInput)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    self.view.backgroundColor=[UIColor darkGrayColor];
    NSInteger margin=40;
    self.imageplace =[[UIView alloc]initWithFrame:CGRectMake(margin, 64+margin, [UIScreen mainScreen].bounds.size.width-2*margin, ([UIScreen mainScreen].bounds.size.width-2*margin)*0.75)];
    self.imageplace.backgroundColor=[UIColor greenColor];
    [self.view addSubview:self.imageplace];
    UILabel * tip=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 10)];
    tip.text=@"点击此处添加图片";
    [self.imageplace addSubview:tip];
    tip.center=CGPointMake(_imageplace.frame.size.width/2, _imageplace.frame.size.height-20);
    self.imageplace.userInteractionEnabled=YES;
    UITapGestureRecognizer * taptoaddimage =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setimage)];
    [self.imageplace addGestureRecognizer:taptoaddimage];
    self.nameinput=[[UITextField alloc]initWithFrame:CGRectMake(2*margin, 64+margin+([UIScreen mainScreen].bounds.size.width-2*margin)*0.75+margin, [UIScreen mainScreen].bounds.size.width-4*margin, 32)];
    _nameinput.placeholder=@"名字";
    _nameinput.borderStyle=UITextBorderStyleRoundedRect;
    self.timeinput=[[UITextField alloc]initWithFrame:CGRectMake(2*margin, 64+3*margin+([UIScreen mainScreen].bounds.size.width-2*margin)*0.75+margin, [UIScreen mainScreen].bounds.size.width-4*margin, 32)];
    _timeinput.placeholder=@"上映时间";
    _timeinput.borderStyle=UITextBorderStyleRoundedRect;
    self.countryinput=[[UITextField alloc]initWithFrame:CGRectMake(2*margin, 64+5*margin+([UIScreen mainScreen].bounds.size.width-2*margin)*0.75+margin, [UIScreen mainScreen].bounds.size.width-4*margin, 32)];
    _countryinput.placeholder=@"国家";
    _countryinput.borderStyle=UITextBorderStyleRoundedRect;
    self.capacityinput=[[UITextField alloc]initWithFrame:CGRectMake(2*margin, 64+7*margin+([UIScreen mainScreen].bounds.size.width-2*margin)*0.75+margin, [UIScreen mainScreen].bounds.size.width-4*margin, 32)];
    _capacityinput.placeholder=@"集数";
    _capacityinput.borderStyle=UITextBorderStyleRoundedRect;
    _timeinput.delegate=self;
    _nameinput.delegate=self;
    _countryinput.delegate=self;
    _capacityinput.delegate=self;
    [self.view addSubview:self.nameinput];
    UIDatePicker *pick = [[UIDatePicker alloc] init];
    pick.datePickerMode = UIDatePickerModeDate;
    NSLocale *local = [NSLocale localeWithLocaleIdentifier:@"zh"];
    pick.locale = local;
    [pick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
//    自定义键盘, 让弹出的键盘是一个UIPickerView
    self.timeinput.inputView = pick;
    self.capacityinput.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:self.timeinput];
    [self.view addSubview:self.countryinput];
    [self.view addSubview:self.capacityinput];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillShowNotification object:nil];
    return self;
}

- (void)dateChange:(UIDatePicker *)datePick{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateString =  [fmt stringFromDate:datePick.date];
    self.timeinput.text = dateString;
}
-(void)setimage{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * library=[[UIImagePickerController alloc]init];
        NSArray * availableType =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        library.mediaTypes=availableType;
        library.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        library.delegate=self;
        [self presentViewController:library animated:YES completion:nil];
    }
    else{
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        NSString *key = nil;
        if (picker.allowsEditing)
        {
            key = UIImagePickerControllerEditedImage;
        }
        else
        {
            key = UIImagePickerControllerOriginalImage;
        }
        //获取图片
        UIImage *image = [info objectForKey:key];
        UIImageView * newimageplace=[[UIImageView alloc]initWithFrame:self.imageplace.frame];
        CGRect frame=CGRectMake(0, 0, _imageplace.frame.size.width,_imageplace.frame.size.height);
        newimageplace.frame=frame;
        newimageplace.image=image;
        self.item.image=image;
        newimageplace.layer.masksToBounds=YES;
        newimageplace.contentMode=UIViewContentModeScaleAspectFill;
        [self.imageplace addSubview:newimageplace];
        if (self.item.name!=nil&&
            self.item.image!=nil&&
            self.item.time!=nil&&
            self.item.country!=nil&&
            self.item.capacity!=nil) {
            self.navigationItem.rightBarButtonItem.enabled=YES;
        }
        else{
            self.navigationItem.rightBarButtonItem.enabled=NO;
        }
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.item.name=_nameinput.text;
    self.item.time=_timeinput.text;
    self.item.country=_countryinput.text;
    self.item.capacity=_capacityinput.text;
    if (self.item.name!=nil&&
        self.item.image!=nil&&
        self.item.time!=nil&&
        self.item.country!=nil&&
        self.item.capacity!=nil) {
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }
    else{
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
}
- (void)DoneWithInput{
    _itemsetter(self.item);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
