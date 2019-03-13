//
//  LPTabBarController.m
//  LPDevTools
//
//  Created by lipeng on 16/10/20.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "LPTabBarController.h"
#import "LPHomeController.h"
#import "LPNavigationController.h"
#import "LPTabBar.h"
@interface LPTabBarController ()

@property (strong, nonatomic) LPHomeController *homeController;

@end

@implementation LPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers {
    UINavigationController *homeNav = [[LPNavigationController alloc]initWithRootViewController:self.homeController];
    UINavigationController *homeNav1 = [[LPNavigationController alloc]initWithRootViewController:[[LPHomeController alloc]init]];
    self.viewControllers = @[homeNav,homeNav1];
    
    [self customTabBarForViewController];
    
    LPTabBar *tabBar = [[LPTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
    
}

- (void)customTabBarForViewController {
    NSInteger index = 0;
    for (UITabBarItem *itemBar in self.tabBar.items) {
        itemBar.title = [self titles][index];
//        itemBar.image = [[UIImage imageNamed:[self images][index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        itemBar.selectedImage = [[UIImage imageNamed:[self selectImages][index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [itemBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
//        [itemBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        index++;
    }
}

- (NSArray *)images {
    return @[@"icon_tabbar",@"icon_tabbar1"];
}
- (NSArray *)selectImages {
    return @[@"icon_select_tabbar",@"icon_select_tabbar1"];
}
- (NSArray *)titles {
    return @[@"Home",@"Home1"];
}

- (LPHomeController *)homeController {
    if (!_homeController) {
        _homeController = [[LPHomeController alloc]init];
    }
    return _homeController;
}

@end
