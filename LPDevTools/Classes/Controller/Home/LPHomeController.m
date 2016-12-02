//
//  LPHomeController.m
//  LPDevTools
//
//  Created by lipeng on 16/10/20.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "LPHomeController.h"
#import "LPSecondViewController.h"
#import "LPTestModel.h"
#import "UIView+EAFeatureGuideView.h"
#import "MBProgressHUD.h"

@interface LPHomeController ()

@end

@implementation LPHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.jz_navigationBarBackgroundAlpha = 0;
    self.title =  [NSString stringWithFormat:@"Screen-%d", self.navigationController.viewControllers.count];
    NSArray *ass = @[];
//    NSString *ss = [ass objectAtIndex:2];
//    NSLog(@"---------------%@",ass[1]);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
//    [view createGlowLayer];
//    [view insertGlowLayer];
//    view.glowColor = [UIColor blackColor];
//    [view startGlowLoop];
    
//    self.view.blurTintColor = [UIColor blueColor];
//    self.view.blurStyle = UIViewBlurDarkStyle;
//    [self.view enableBlur:YES];
    
//    [[NetWorkUrlConfig sharedManager]getUrl:NetWorkRequestUrl_QueryProjectList parameters:@{@"MemberId":@"",
//                                                                                           @"Category":@"",
//                                                                                           @"Status":@"",
//                                                                                           @"PageSize":@"10",
//                                                                                           @"PageIndex":@"1"} className:NSStringFromClass([LPTestModel class]) responseBlock:^(NetWorkResponse *response) {
//                                                                                               
//                                                                                           }];
    
    NSTimeInterval time = [@"1480398973.020156" doubleValue];
    DebugLog(@"----------%f,%@",[[NSDate date]timeIntervalSince1970],[NSDate dateWithTimeIntervalSince1970:time]);
    
//    [self.view showLoadHUD];
//    [self.view showLoadHUDTitle:@"加"];
//    [self.view showTip:@"搜索"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[[LPSecondViewController alloc]init] animated:YES];
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
