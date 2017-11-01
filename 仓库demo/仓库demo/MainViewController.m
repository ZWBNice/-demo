//
//  MainViewController.m
//  LifeCool
//
//  Created by 张文博 on 16/8/22.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "CargoViewController.h"
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height
#define NAVCTITLE_COLOR  [UIColor whiteColor]

@interface MainViewController ()<UINavigationControllerDelegate,UITabBarControllerDelegate>

@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBar.tintColor = [UIColor blackColor];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.tabBar insertSubview:backView atIndex:0];
        self.tabBar.opaque = YES;
        self.tabBar.translucent = NO;
        self.delegate = self;
        [self initViewControllers];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
}

- (void)initViewControllers {
    
     HomeViewController *homeVC = [[HomeViewController alloc] init];
    CargoViewController *CargoVC = [[CargoViewController alloc] init];
    //    first.hidesBottomBarWhenPushed = true;
    //    kpVC.hidesBottomBarWhenPushed = true;
    //    lkVC.hidesBottomBarWhenPushed = true;
    //    myVC.hidesBottomBarWhenPushed = true;
    
    
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"销售记录" image:[self drawimage:[UIImage imageNamed:@"29业务 (1)"]] selectedImage:[UIImage imageNamed:@"29业务"]];
    CargoVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"仓库" image:[self drawimage:[UIImage imageNamed:@"12库存 (1)"]] selectedImage:[UIImage imageNamed:@"12库存"]];

    

    NSArray *titleArr = @[@"销售记录",@"仓库"];
    NSArray *viewControllers = @[homeVC, CargoVC];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
    for (int i = 0; i < 2; i++) {
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:viewControllers[i]];
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] init];
        navc.navigationItem.backBarButtonItem = btn;
        navc.navigationBar.tintColor = [UIColor blackColor];
        [arr addObject:navc];
        navc.title = titleArr[i];
        navc.delegate = self;
    }
    self.viewControllers = arr;
}

- (UIImage *)drawimage:(UIImage *)image{
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
