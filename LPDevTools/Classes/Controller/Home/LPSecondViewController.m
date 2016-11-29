//
//  LPSecondViewController.m
//  LPDevTools
//
//  Created by lipeng on 16/10/26.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "LPSecondViewController.h"

@interface LPSecondViewController ()

@end

@implementation LPSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    NSLog(@"%@",self.navigationController.viewControllers);
    
}

- (BOOL)navigationShouldPopOnBackButton {
    NSLog(@"------%@",NSStringFromClass([self class]));
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
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
