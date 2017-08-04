//
//  LPPictureBrowser.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/8/1.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPPictureBrowser.h"
#import "LPPictureCollectionViewCell.h"

@interface LPPictureBrowser ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *pageTextLabel;
@property (nonatomic, assign) BOOL showAnim;

@end

@implementation LPPictureBrowser

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor blackColor];
    [collectionView registerClass:[LPPictureCollectionViewCell class] forCellWithReuseIdentifier:LPPictureCollectionViewCellKey];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.maximumZoomScale= 3.0;
    collectionView.pagingEnabled = YES;
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // 初始化label
    UILabel *label = [[UILabel alloc] init];
    label.alpha = 0;
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 20);
    label.font = [UIFont systemFontOfSize:16];
    [self addSubview:label];
    self.pageTextLabel = label;
    
}

- (void)show {
    //添加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.pageTextLabel.text = [NSString stringWithFormat:@"%zd/%zd",_currentPhotoIndex, _pictures.count];
    self.pageTextLabel.alpha = 1;
    _showAnim = true;
    [_collectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * _currentPhotoIndex, 0)];
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LPPictureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LPPictureCollectionViewCellKey forIndexPath:indexPath];
    [cell refreshCellWithPictures:_pictures[indexPath.row] showAnim:_showAnim];
    if (_showAnim) {
        _showAnim = false;
    }
    return cell;
}


@end
