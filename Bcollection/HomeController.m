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
-(NSMutableArray *)arr{
    if (_arr==nil) {
        _arr=[[NSMutableArray alloc]init];
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
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"🔍" style:0 target:nil action:nil];
    // Do any additional setup after loading the view.
}


#pragma mark <UICollectionViewDataSource>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arr.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==_arr.count) {
        BiliCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.backgroundColor=[UIColor yellowColor];
        UIButton * add =[UIButton buttonWithType:UIButtonTypeContactAdd];
        [add addTarget:self action:@selector(addBiliItem) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:add];
        add.center=CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2);
        return cell;
    }
    else{
        BiliCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.backgroundColor=[UIColor redColor];
        return cell;
    }

}
-(void)addBiliItem{
    AddItemPage * page=[[AddItemPage alloc]init];
    page.itemsetter = ^(BiliItem *item) {
        [self.arr addObject:item];
        [self.navigationController  popViewControllerAnimated:YES ];
        [self.collectionView reloadData];
    };
    [self.navigationController pushViewController:page animated:YES];
}

-(void)saveItem:(BiliItem*)item{
    NSString * imageName=[item.name stringByAppendingString:item.time];
    [self saveImage:item.image WithName:imageName];
    
}

- (void)saveImage:(UIImage *)image WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(image);
    NSString* libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fullPath = [libraryPath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
    
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
