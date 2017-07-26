//
//  LPSecondViewController.m
//  LPDevTools
//
//  Created by lipeng on 16/10/26.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "LPSecondViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface LPSecondViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LPSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    NSLog(@"%@",self.navigationController.viewControllers);
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    NSString *htmlStr = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSString *str = [NSString stringWithContentsOfFile:htmlStr encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:str baseURL:nil];
}

- (BOOL)navigationShouldPopOnBackButton {
    NSLog(@"------%@",NSStringFromClass([self class]));
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

#pragma -mark  --WebViewDelegate
//加载之前调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
//开始加载调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
//加载完成调用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"btnClick1"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString * func = [NSString stringWithFormat:@"alertName('%@');",@"OC后台传入数据"];
        [context evaluateScript:func];
    };
    
    context[@"test"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSLog(@"%@",args);
        NSString * func = [NSString stringWithFormat:@"alertSendMsg('%@','%@');",@"1999999",@"OC后台传入数据"];
        [context evaluateScript:func];
    };
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
