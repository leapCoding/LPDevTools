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
//#import "UIView+EAFeatureGuideView.h"
#import "MBProgressHUD.h"
#import "LPPictureBrowser.h"
#import "LPPicture.h"
#import "UIImageView+WebCache.h"

#import "LPSlideBar.h"
#import "iCarousel.h"

@interface LPHomeController ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LPSlideBar *slidebar;
@property (strong, nonatomic) iCarousel *myCarousel;

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
//    DebugLog(@"----------%f,%@",[[NSDate date]timeIntervalSince1970],[NSDate dateWithTimeIntervalSince1970:time]);
    
//    [self.view showLoadHUD];
//    [self.view showLoadHUDTitle:@"加"];
//    [self.view showTip:@"搜索"];
    
    [self testDemo];
    
    
    //添加myCarousel
    self.myCarousel = ({
        iCarousel *icarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 100)];
        icarousel.dataSource = self;
        icarousel.delegate = self;
        icarousel.decelerationRate = 1.0;
        icarousel.scrollSpeed = 1.0;
        icarousel.type = iCarouselTypeLinear;
        icarousel.pagingEnabled = YES;
        icarousel.clipsToBounds = YES;
        icarousel.bounceDistance = 0.2;
        [self.view addSubview:icarousel];
        
        icarousel;
    });

    
    _slidebar = [[LPSlideBar alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
//    slidebar.backgroundColor = [UIColor redColor];
    _slidebar.itemsTitle = @[@"圣诞快乐",@"圣诞乐",@"圣快乐",@"诞快乐",@"圣诞快",@"圣诞快乐",@"圣诞乐",@"圣快乐",@"诞快乐",@"圣诞快"];
    _slidebar.showRightButton = YES;
    [self.view addSubview:_slidebar];
    __weak typeof(self) weakSelf = self;
    [_slidebar slideBarItemSelectedCallback:^(NSUInteger idx) {
        NSLog(@"%ld",idx);
        [weakSelf.myCarousel scrollToItemAtIndex:idx animated:NO];
    }];
}

#pragma mark iCarousel M

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 10;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    
    UIView *listView = view;
    UILabel *label;
    if (listView) {
        
    }else{
        listView = [[UIView alloc] initWithFrame:carousel.bounds];
        label = [[UILabel alloc]initWithFrame:listView.bounds];
        [listView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%ld",index];
    NSLog(@"---%ld",index);
    
//    [listView setSubScrollsToTop:(index == carousel.currentItemIndex)];
    return listView;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    if (_slidebar) {
        float offset = carousel.scrollOffset;
        if (offset > 0) {
            [_slidebar moveIndexWithProgress:offset];
        }
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
    if (_slidebar) {
//        _slidebar.currentIndex = carousel.currentItemIndex;
    }
    
}


- (void)testDemo {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 150, 150)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = true;
    imageView.tag = 1;
    imageView.userInteractionEnabled = true;
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://cdn.ruguoapp.com/FsZAUtf8serLpkdTJIh0mqUmpTeN.jpg?imageView2/0/h/500/interlace/1/q/30"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self.view addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(170, 100, 150, 150)];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.clipsToBounds = true;
    imageView1.tag = 2;
    imageView1.userInteractionEnabled = true;
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://139.129.162.63:8085/img2/pub/imgs/ser_item/img/weixiu/peijiangenghuan/ghdengpao.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self.view addSubview:imageView1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
    [imageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
    [imageView1 addGestureRecognizer:tap1];
}

- (void)imageViewTap:(UITapGestureRecognizer *)ges {
    
    LPPictureBrowser *picture = [[LPPictureBrowser alloc]init];
    UIImageView *imageview = [self.view viewWithTag:1];
    picture.currentPhotoIndex = ges.view.tag -1;
    LPPicture *p = [[LPPicture alloc]init];
    p.imageView = imageview;
//    p.picurl = @"http://cdn.ruguoapp.com/FsZAUtf8serLpkdTJIh0mqUmpTeN.jpg?imageView2/0/h/1000/interlace/0";
    p.placeholderImage = imageview.image;
    
    UIImageView *imageview1 = [self.view viewWithTag:2];
    LPPicture *p1 = [[LPPicture alloc]init];
//    p1.picurl = @"http://139.129.162.63:8085/img2/pub/imgs/ser_item/img/weixiu/peijiangenghuan/ghdengpao.jpg";
    p1.imageView = imageview1;
    p1.placeholderImage = imageview1.image;
    
    picture.pictures = @[p,p1];
    picture.currentPhotoIndex = ges.view.tag-1;
    [picture show];
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
