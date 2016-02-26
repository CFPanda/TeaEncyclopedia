//
//  DCFGuideViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/15.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "DCFGuideViewController.h"
#import "DCFTeaViewController.h"
@interface DCFGuideViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scoll;

@end

@implementation DCFGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建scoll滚动视图
    _scoll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_scoll];
    _scoll.showsHorizontalScrollIndicator = NO;
    _scoll.showsVerticalScrollIndicator = NO;
    _scoll.contentSize = CGSizeMake(self.view.frame.size.width*3, 0);
    _scoll.pagingEnabled = YES;
    _scoll.bounces = NO;
    _scoll.delegate = self;

   
    
    //创建
    for (int i = 0 ; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, _scoll.frame.size.width, _scoll.frame.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"slide%d",i+1]];
        [_scoll addSubview:imageView];
        
    }

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == self.view.frame.size.width*2) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        button.frame = self.view.bounds;
        [button addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
    }
}


//TODU:点击按钮进入主页
-(void)clickBtn{
    DCFTeaViewController *dcfVc = [[DCFTeaViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:dcfVc];
    [[UIApplication sharedApplication] keyWindow].rootViewController = nav;

}


@end
