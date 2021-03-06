//
//  AppDelegate.m
//  Bcollection
//
//  Created by 李嘉银 on 2017/10/31.
//  Copyright © 2017年 lAgagggggg. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置间距
        NSInteger margin = 10;
        NSInteger Col=2;
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        
        //设置item尺寸
        CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - (Col + 1) * margin) / Col;
        CGFloat itemH = itemW;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
        // 设置水平滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout;
    });
    HomeController *homecontroller = [[HomeController alloc]initWithCollectionViewLayout:layout];
    UINavigationController * navigationC=[[UINavigationController alloc]initWithRootViewController:homecontroller];
    navigationC.navigationBar.tintColor=[UIColor blackColor];
//    UIView * trashView=[[UIView alloc]initWithFrame:CGRectMake(12, 8, 25, 25)];
//    trashView.backgroundColor=[UIColor darkGrayColor];
//    [navigationC.navigationBar addSubview: trashView];
    self.window.rootViewController = navigationC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
