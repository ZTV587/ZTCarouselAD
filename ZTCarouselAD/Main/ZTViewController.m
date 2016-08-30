//
//  Created by ZZT on 15/9/15.
//  Copyright © 2015年 ZZT. All rights reserved.
//
#import "ZTViewController.h"
//要添加的标题
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
//广告轮播图
#import "ZTPageView.h"

@interface ZTViewController ()

@end

@implementation ZTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加广告轮播图
    [self addCarouselAD];
    
    //添加所有标题控制器
    [self addAllTitleViewControllers];
    
}

//添加所有子控制器
- (void)addAllTitleViewControllers {
    
    // 第一个
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    firstVc.title = @"第一个";
    [self addChildViewController:firstVc];
    
    // 第二个
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    secondVc.title = @"第二个";
    [self addChildViewController:secondVc];
    
    // 第三个
    ThirdViewController *thirdVc = [[ThirdViewController alloc] init];
    thirdVc.title = @"第三个";
    [self addChildViewController:thirdVc];
    
    FourthViewController *fourthVc = [[FourthViewController alloc] init];
    fourthVc.title = @"第四个";
    [self addChildViewController:fourthVc];
    
    FifthViewController *fifthVc = [[FifthViewController alloc] init];
    fifthVc.title = @"第五个";
    [self addChildViewController:fifthVc];
}

//广告轮播
-(void)addCarouselAD {
    
    ZTPageView *pageView = [ZTPageView pageView];
    CGFloat pageX = 0;
    CGFloat pageY = 64;
    CGFloat pageW = [UIScreen mainScreen].bounds.size.width;
    //高度最好自己做一下适配比较好!!
    CGFloat pageH = 130;
    pageView.frame = CGRectMake(pageX, pageY, pageW, pageH);

    //轮播的广告图放在数组中
    pageView.imageNames = @[@"img_01",@"img_02",@"img_03"];
    
    [self.view addSubview:pageView];
}
@end
