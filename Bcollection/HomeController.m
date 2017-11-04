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

@end

@implementation HomeController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self=[super initWithCollectionViewLayout:layout];
    self.searchView=[[UITableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.searchView.delegate=self;
    self.searchView.dataSource=self;
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.searchView addGestureRecognizer:pan];
    [self.view addSubview:self.searchView];
    return self;
}

-(void)CallSearchView{
    [UIView animateWithDuration:0.8 animations:^{
        CGRect f=self.searchView.frame;
        if (f.origin.x==0) {
            f.origin.x=[UIScreen mainScreen].bounds.size.width;
            self.collectionView.alpha=1;
        }
        else{
            f.origin.x=0;
            self.collectionView.alpha=0;
        }
        self.searchView.frame=f;
    }];
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
        }];
    }
    ratio=f.origin.x/[UIScreen mainScreen].bounds.size.width;
    self.collectionView.alpha=ratio;
    [pan setTranslation:CGPointZero inView:self.searchView];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * searchBar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 64)];
    UITextField * searchField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 64)];
    searchField.placeholder=@"搜索";
    searchField.borderStyle=UITextBorderStyleRoundedRect;
    [searchBar addSubview:searchField];
    return searchBar;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor redColor];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[BiliCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor=[UIColor darkGrayColor];
    self.navigationItem.title=@"主页";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"🔍" style:0 target:self action:@selector(CallSearchView)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"🗑" style:0 target:self action:@selector(ActiveDelete)];
    self.navigationController.navigationBar.barTintColor =[UIColor darkGrayColor];
    self.navigationController.navigationBar.tintColor =[UIColor blackColor];
    // Do any additional setup after loading the view.
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
        cell.backgroundColor=[UIColor yellowColor];
        UIButton * add =[UIButton buttonWithType:UIButtonTypeContactAdd];
        [add addTarget:self action:@selector(addBiliItem) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:add];
        NSLog(@"add");
        add.center=CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2);
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
