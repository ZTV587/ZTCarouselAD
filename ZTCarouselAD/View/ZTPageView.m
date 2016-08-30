//
//  Created by ZZT on 15/9/15.
//  Copyright © 2015年 ZZT. All rights reserved.
//

#import "ZTPageView.h"
#define iPhone6P ([UIScreen mainScreen].bounds.size.height == 736)
#define iPhone6 ([UIScreen mainScreen].bounds.size.height == 667)
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)

@interface ZTPageView () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic ,weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollerViewW;
@end
@implementation ZTPageView

- (void)awakeFromNib
{
    // 1.设置pageControl单页的时候是否隐藏
    self.pageControl.hidesForSinglePage = YES;

    // 2.设置pageControl显示的图片(KVC)
    [self.pageControl setValue:[UIImage imageNamed:@"current"] forKeyPath:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"other"] forKeyPath:@"_pageImage"];
    
    // 3.开启定时器
    [self startTimer];
    
}

+ (instancetype)pageView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    // 0.移除之前添加的imageView
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    // 1.根据图片名数据创建ImageView添加到scrollView中
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    
    //适配宽度
    if (iPhone6P) {
        self.scrollerViewW.constant = 414.0;
        scrollViewW = self.scrollerViewW.constant;
    } else if (iPhone6) {
        self.scrollerViewW.constant = 375.0;
        scrollViewW = self.scrollerViewW.constant;
    } else if (iPhone5) {
        self.scrollerViewW.constant = 320.0;
        scrollViewW = self.scrollerViewW.constant;
    } else if (iPhone4) {
        self.scrollerViewW.constant = 320.0;
        scrollViewW = self.scrollerViewW.constant;
    }
    
    NSUInteger count = imageNames.count;
    for (int  i = 0; i < count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [self.scrollView addSubview:imageView];
    }
    
    // 2.设置contentSize
    //  0表示垂直方向不能滚动
    self.scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);

    // 3.设置总页数
    self.pageControl.numberOfPages = count;
    
}

#pragma mark - 定时器的相关方法
- (void)startTimer {
    
    // 返回一个会自动执行任务的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage:) userInfo:@"123" repeats:YES];

    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];

}


/**
 *  滚动到下一页
 */
- (void)nextPage:(NSTimer *)timer
{
    // 计算下一页页码
    NSInteger page = self.pageControl.currentPage + 1;
    
    // 超过最后一页
    if (page == self.imageNames.count) {
        page = 0;
    }
    // 滚动到下一页
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0) animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算页码
    int page =  (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = page;
}

/**
 *  用户即将开始拖拽scrollView,停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  用户已经停止拖拽scrollView,开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

@end
