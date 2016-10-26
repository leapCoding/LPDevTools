//
//  LPNavigationController.m
//  LPDevTools
//
//  Created by lipeng on 16/10/21.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "LPNavigationController.h"

@interface LPNavigationController ()

@end

@implementation LPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.jz_navigationBarTransitionStyle = JZNavigationBarTransitionStyleDoppelganger;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
