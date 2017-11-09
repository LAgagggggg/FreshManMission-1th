//
//  HomeController.m
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()
@property(strong,nonatomic)NSMutableArray<BiliItem*>* arr;
@property(strong,nonatomic)NSMutableArray<BiliItem*>* searchResultArr;
@property(strong,nonatomic) NSString * archiverPath;
@property(strong,nonatomic) UITableView * searchView;
@property(strong,nonatomic) UIView * searchBar;
@property(strong,nonatomic) UIButton * namesearchbutton;
@property(strong,nonatomic) UIButton * countrysearchbutton;
@property(strong,nonatomic) UIButton * datesearchbutton;
@property(strong,nonatomic) UITextField * searchField;
@property(strong,nonatomic) UIView * trashView;
@property enum{
SearchByName,
SearchByCountry,
SearchByDate,
}SearchCondition;
@end

@implementation HomeController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const searchreuseIdentifier = @"SearchCell";

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self=[super initWithCollectionViewLayout:layout];
    self.searchView=[[UITableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.searchView.rowHeight=64;
    self.searchView.delegate=self;
    self.searchView.dataSource=self;
    self.searchBar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.searchView.frame.size.width, 64+32)];
    self.self.searchField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.searchView.frame.size.width, 60)];
    self.namesearchbutton =[UIButton buttonWithType:UIButtonTypeSystem];
    self.namesearchbutton.frame=CGRectMake(0, 64, self.searchView.frame.size.width/3, 32);
    self.countrysearchbutton =[UIButton buttonWithType:UIButtonTypeSystem];
    self.countrysearchbutton.frame= CGRectMake(self.searchView.frame.size.width*1/3, 64, self.searchView.frame.size.width/3, 32);
    self.datesearchbutton =[UIButton buttonWithType:UIButtonTypeSystem];
    self.datesearchbutton.frame= CGRectMake(self.searchView.frame.size.width*2/3, 64, self.searchView.frame.size.width/3, 32);
    [self.namesearchbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.countrysearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.datesearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.namesearchbutton.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.namesearchbutton.bounds;
    maskLayer.path = maskPath.CGPath;
    self.namesearchbutton.layer.mask = maskLayer;
    self.namesearchbutton.layer.masksToBounds = YES;
    self.namesearchbutton.layer.borderColor = [[UIColor redColor] CGColor];
    self.namesearchbutton.layer.borderWidth = 1.0f;
    self.countrysearchbutton.layer.masksToBounds = YES;
    self.countrysearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.countrysearchbutton.layer.borderWidth = 1.0f;
    UIBezierPath *maskPathfordate = [UIBezierPath bezierPathWithRoundedRect:self.namesearchbutton.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10.0)];
    CAShapeLayer *maskLayerfordate = [[CAShapeLayer alloc]init];
    maskLayerfordate.frame = self.datesearchbutton.bounds;
    maskLayerfordate.path = maskPathfordate.CGPath;
    self.datesearchbutton.layer.mask = maskLayerfordate;
    self.datesearchbutton.layer.masksToBounds = YES;
    self.datesearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.datesearchbutton.layer.borderWidth = 1.0f;
    [self.namesearchbutton addTarget:self action:@selector(searchByName) forControlEvents:UIControlEventTouchUpInside];
    [self.countrysearchbutton addTarget:self action:@selector(searchByCountry) forControlEvents:UIControlEventTouchUpInside];
    [self.datesearchbutton addTarget:self action:@selector(searchByDate) forControlEvents:UIControlEventTouchUpInside];
    [self.namesearchbutton setTitle:@"名字" forState:UIControlStateNormal];
    [self.countrysearchbutton setTitle:@"国家" forState:UIControlStateNormal];
    [self.datesearchbutton setTitle:@"上映时间" forState:UIControlStateNormal];
    self.SearchCondition=SearchByName;
    self.searchField.placeholder=@"搜索";
    self.searchField.borderStyle=UITextBorderStyleBezel;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchField.autocorrectionType=UITextAutocorrectionTypeNo;
    self.searchField.delegate=self;
    [self.searchBar addSubview:self.searchField];
    [self.searchBar addSubview:self.namesearchbutton];
    [self.searchBar addSubview:self.countrysearchbutton];
    [self.searchBar addSubview:self.datesearchbutton];
    self.searchView.tableHeaderView=self.searchBar;
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    [self.searchView addGestureRecognizer:pan];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.searchView];
    return self;
}

-(void)searchByName{
    [self.namesearchbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.countrysearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.datesearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.namesearchbutton.layer.borderColor = [[UIColor redColor] CGColor];
    self.countrysearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.datesearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.SearchCondition=SearchByName;
    [self SearchAndMakeResultArr:self.searchField.text];
    [self.searchView reloadData];
}

-(void)searchByCountry{
    [self.namesearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.countrysearchbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.datesearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.namesearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.countrysearchbutton.layer.borderColor = [[UIColor redColor] CGColor];
    self.datesearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.SearchCondition=SearchByCountry;
    [self SearchAndMakeResultArr:self.searchField.text];
    [self.searchView reloadData];
}

-(void)searchByDate{
    [self.namesearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.countrysearchbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.datesearchbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.namesearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.countrysearchbutton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.datesearchbutton.layer.borderColor = [[UIColor redColor] CGColor];
    self.SearchCondition=SearchByDate;
    [self SearchAndMakeResultArr:self.searchField.text];
    [self.searchView reloadData];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self SearchAndMakeResultArr:text];
    [self.searchView reloadData];
    return YES;
}

-(void)SearchAndMakeResultArr:(NSString *)searchCondition{
    [self.searchResultArr removeAllObjects];
    switch (self.SearchCondition) {
        case SearchByName :
            for (BiliItem * item in self.arr) {
                if ([item.name rangeOfString:searchCondition].location!=NSNotFound) {
                    [self.searchResultArr addObject:item];
                }
            }
            break;
        case SearchByCountry:
            for (BiliItem * item in self.arr) {
                if ([item.country rangeOfString:searchCondition].location!=NSNotFound) {
                    [self.searchResultArr addObject:item];
                }
            }
            break;
        case SearchByDate:
            for (BiliItem * item in self.arr) {
                if ([item.time rangeOfString:searchCondition].location!=NSNotFound) {
                    [self.searchResultArr addObject:item];
                }
            }
            break;
    }
}

-(void)CallSearchView{
    for(UITextField *subview in self.searchBar.subviews)
    {
        [subview resignFirstResponder];
    }
    [UIView animateWithDuration:0.8 animations:^{
        CGRect f=self.searchView.frame;
        if (f.origin.x==0) {
            f.origin.x=[UIScreen mainScreen].bounds.size.width;
            self.collectionView.alpha=1;
            self.navigationItem.leftBarButtonItem.customView.alpha=1;
        }
        else{
            f.origin.x=0;
            self.collectionView.alpha=0;
            self.navigationItem.leftBarButtonItem.customView.alpha=0;
        }
        self.searchView.frame=f;
    }];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.searchBar]) {
        
    }
    else{
        for(UITextField *subview in self.searchBar.subviews)
        {
            [subview resignFirstResponder];
        }
    }
    return NO;
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint transP = [pan translationInView:self.searchView];
    CGRect f=self.searchView.frame;
    f.origin.x+=transP.x;
    if (f.origin.x<0) {
        f.origin.x=0;
    }
    float ratio=self.searchView.frame.origin.x;
    self.searchView.frame=f;
    if(pan.state == UIGestureRecognizerStateEnded){
        if (f.origin.x<[UIScreen mainScreen].bounds.size.width*2/3) {
            f.origin.x =0;
        }
        else{
            f.origin.x =[UIScreen mainScreen].bounds.size.width;
        }
        ratio=f.origin.x/[UIScreen mainScreen].bounds.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            self.searchView.frame=f;
            self.collectionView.alpha=ratio;
            self.navigationItem.leftBarButtonItem.customView.alpha=ratio;
        }];
    }
    ratio=f.origin.x/[UIScreen mainScreen].bounds.size.width;
    self.collectionView.alpha=ratio;
    self.navigationItem.leftBarButtonItem.customView.alpha=ratio;
    [pan setTranslation:CGPointZero inView:self.searchView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResultArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[self.searchView dequeueReusableCellWithIdentifier:searchreuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text=self.searchResultArr[indexPath.row].name;
    cell.imageView.image=self.searchResultArr[indexPath.row].image;
    return cell;
}

-(NSMutableArray *)arr{
    if (_arr==nil) {
        NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.archiverPath=[documentPath stringByAppendingPathComponent:@"biliData.data"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:self.archiverPath]){
            NSLog(@"file detected");
            _arr=[NSKeyedUnarchiver unarchiveObjectWithFile:self.archiverPath];
            [self.collectionView reloadData];
        }
        else{
            _arr=[[NSMutableArray alloc]init];
        }
    }
    return  _arr;
}

-(NSMutableArray *)searchResultArr{
    if (_searchResultArr==nil) {
        _searchResultArr=[[NSMutableArray alloc]init];
    }
    return  _searchResultArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[BiliCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.searchView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchreuseIdentifier];
    self.collectionView.backgroundColor=[UIColor darkGrayColor];
    self.navigationItem.title=@"主页";
    UIView * trashView=[[UIView alloc]initWithFrame:CGRectMake(0,0, 50, 50)];
    UIButton * trashButton=[UIButton buttonWithType:UIButtonTypeCustom];
    trashButton.frame=CGRectMake(-15,-2, 50, 50);
    [trashButton setTitle: @"🗑" forState:UIControlStateNormal];
    [trashButton addTarget:self action:@selector(ActiveDelete) forControlEvents:UIControlEventTouchUpInside];
    [trashView addSubview:trashButton];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"🔍" style:0 target:self action:@selector(CallSearchView)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:trashView];
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"🗑" style:0 target:self action:@selector(ActiveDelete)];
}


#pragma mark <UICollectionViewDataSource>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==_arr.count) {
        BiliCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
        cell.backgroundColor=[UIColor lightGrayColor];
        UIButton * add =[UIButton buttonWithType:UIButtonTypeContactAdd];
        [add addTarget:self action:@selector(addBiliItem) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:add];
        NSLog(@"add");
        add.center=CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = cell.bounds;
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
        return cell;
    }
    else{
        BiliCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cell setCellWithItem:self.arr[indexPath.row]];
        cell.deleteButton.tag=indexPath.row;
        cell.deleteCell = ^(NSInteger index) {
            [self.arr removeObjectAtIndex:index];
            [self.collectionView reloadData];
            [self saveData];
        };
        return cell;
    }
    
}
-(void)addBiliItem{
    AddItemPage * page=[[AddItemPage alloc]init];
    page.itemsetter = ^(BiliItem *item) {
        [self.arr addObject:item];
        [self.navigationController  popViewControllerAnimated:YES ];
        [self.collectionView reloadData];
        [self saveData];
    };
    [self.navigationController pushViewController:page animated:YES];
}

-(void)saveData{
    [NSKeyedArchiver archiveRootObject:self.arr toFile:self.archiverPath];
}
-(void)ActiveDelete{
    for (BiliCell * cell in self.collectionView.subviews) {
        if ([cell isMemberOfClass:[BiliCell class]]) {
            [UIView animateWithDuration:0.8 animations:^{
                cell.deleteButton.enabled=!cell.deleteButton.enabled;
                if (cell.deleteButton.enabled==YES) {
                    cell.deleteButton.alpha=1;
                }
                else{
                    cell.deleteButton.alpha=0;
                }
            }];
            
        }
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<self.arr.count) {
        DetailView * detailview=[[DetailView alloc]initWithItem:self.arr[indexPath.row]];
        detailview.itemsetter = ^(BiliItem *item) {
            [self.arr replaceObjectAtIndex:indexPath.row withObject:item];
            [self.navigationController  popViewControllerAnimated:YES ];
            [self.collectionView reloadData];
            [self saveData];
        };
        [self.navigationController pushViewController:detailview animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index=[self.arr indexOfObject:self.searchResultArr[indexPath.row]];
    DetailView * detailview=[[DetailView alloc]initWithItem:self.arr[index]];
    detailview.itemsetter = ^(BiliItem *item) {
        [self.arr replaceObjectAtIndex:index withObject:item];
        [self.navigationController  popViewControllerAnimated:YES ];
        [self performSelector:@selector(CallSearchView)];
        [self.collectionView reloadData];
        [self saveData];
    };
    [self.navigationController pushViewController:detailview animated:YES];
}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

@end
