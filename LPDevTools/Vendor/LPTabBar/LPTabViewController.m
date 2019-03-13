//
//  LPTabViewController.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/9/8.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPTabViewController.h"
#import "LPSecondViewController.h"
#import "LPTabBar.h"

@interface LPTabViewController ()

@end

@implementation LPTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupChildVc:[[LPSecondViewController alloc] init] title:@"精华" image:@"" selectedImage:@"icon_select_tabbar"];
    [self setupChildVc:[[LPSecondViewController alloc] init] title:@"精华" image:@"" selectedImage:@"icon_select_tabbar"];
    [self setupChildVc:[[LPSecondViewController alloc] init] title:@"精华" image:@"icon_tabbar" selectedImage:@"icon_select_tabbar"];
    [self setupChildVc:[[LPSecondViewController alloc] init] title:@"精华" image:@"icon_tabbar" selectedImage:@"icon_select_tabbar"];
    
    LPTabBar *tabBar = [[LPTabBar alloc]init];
    
    [self setValue:tabBar forKey:@"tabBar"];
}

-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    UINavigationController *navVc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navVc];
    navVc.tabBarItem.badgeValue = @"1";
    //设置文字和图片
    navVc.tabBarItem.title = title;
    navVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [navVc.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
    NSDictionary *dictHome1 = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [navVc.tabBarItem setTitleTextAttributes:dictHome1 forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
