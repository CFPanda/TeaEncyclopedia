//
//  HeadlinesViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/16.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "HeadlinesViewController.h"
#import "BannerModel.h"
#import "UIImageView+WebCache.h"
#import "BannerScrollView.h"
#import "BannerViewController.h"

@interface HeadlinesViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)BannerScrollView *scroll;

@end

@implementation HeadlinesViewController
{
    UIPageControl *_page;
    NSTimer *_timer;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.frame = CGRectMake(0, 120, kScreenSizeWidth, kScreenSize.height-184);
    _bannerArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self createUI];
    [self createTableViewData];
    [self createBannerData];
}


#pragma mark - 创建横幅滚动视图 和 pageView

-(void)createUI{
    //实例化scrollView
    _scroll = [[BannerScrollView alloc]initWithFrame:CGRectMake(0, 0,kScreenSizeWidth, 120)];
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    _scroll.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;

    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kScreenSizeWidth*4, 0);
    
    //实例化PageController
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];
    _page.center = CGPointMake(kScreenSizeWidth-60, 114);
   
    _page.numberOfPages = 3;
    [_page addTarget:self action:@selector(pageChangeScrollImage:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_page];

}


#pragma mark - page的触发事件

-(void)pageChangeScrollImage:(UIPageControl *)page{
        [_scroll setContentOffset:CGPointMake(kScreenSizeWidth*page.currentPage, 0) animated:YES];
}


#pragma mark - 请求数据

-(void)createTableViewData{
   [self requestWithUrlString:@"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.getHeadlines"];
}

-(void)createBannerData{
    [self requestWithUrlString:@"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.getSlideshow"];
}

-(void)requestSucessWithInfo:(NSDictionary *)info{
    
    if ([info[@"data"] count] == 3) {
        for (NSDictionary *dic in info[@"data"]) {
            BannerModel *model = [[BannerModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_bannerArray addObject:model];
            
        }
        [self performSelectorOnMainThread:@selector(relayoutBanner:) withObject:_bannerArray waitUntilDone:YES];
        
    }else{
        for (NSDictionary *dic in info[@"data"]) {
            CellModel *model = [[CellModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        [MMProgressHUD dismissWithSuccess:@"加载成功~"];
    }
    
}


#pragma mark - 数据请求完成后刷新scroll布局

-(void)relayoutBanner:(NSMutableArray *)mrr{
    for (int i = 0; i <= mrr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenSizeWidth*i,0,kScreenSizeWidth,120)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
        
        if (i == mrr.count) {
            BannerModel *model = mrr[0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 106,kScreenSizeWidth, 14)];
            title.backgroundColor  =[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
            title.textColor = [UIColor whiteColor];
            title.text = model.title;
            [imageView addSubview:title];
            imageView.tag = 1000+i;
            title.font = [UIFont systemFontOfSize:14];
            
            
            [imageView addGestureRecognizer:tap];
        }else {
            //总共添加四张图片,最后一张跟第一张相同,这么做是为了保证在使用定时器循环播放到最后一张的的时候不会出现跳跃式 变化
            BannerModel *model = mrr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.image_s]];
            //灰色的标题lable
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0,106,kScreenSizeWidth, 14)];
            title.backgroundColor  =[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
            title.textColor = [UIColor whiteColor];
            [imageView addSubview:title];
             title.text = model.title;
            title.font = [UIFont systemFontOfSize:14];
            imageView.tag = 1000+i;
            
            [imageView addGestureRecognizer:tap];
            
            
        }
        imageView.userInteractionEnabled = YES;
        
        [_scroll addSubview:imageView];
    }
    //实例化定时器 在scrollView上的子控件加载完成后在开启定时器是为了保证 图片加载出来才会惊醒循环播放
    [self createTimer];
}

-(void)clickTap:(UITapGestureRecognizer *)tap{
    
    switch (tap.view.tag) {
        
        case 1000:
            self.Tappush([_bannerArray[0] link]);
            break;
        case 1001:
            self.Tappush([_bannerArray[1] link]);
            break;
            
        case 1002:
            self.Tappush([_bannerArray[2] link]);
            break;
            
        case 1003:
            self.Tappush([_bannerArray[0] link]);
            break;
        default:
            break;
            
           
    }
    
    
}

#pragma mark - tableViewDelegte

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CellModel *model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell relayoutCellWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellModel *model = self.dataArray[indexPath.row];
    return model.height;
}


#pragma mark - 定时器方法

-(void)createTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(runningTimer) userInfo:nil repeats:YES];
    
}
-(void)runningTimer{
    if (!(_scroll.isDecelerating ||_scroll.isDragging)) {
        int page = _scroll.contentOffset.x/kScreenSizeWidth;
        [_scroll setContentOffset:CGPointMake(++page*self.view.bounds.size.width, 0) animated:YES];
        _page.currentPage = page;
    }
}


#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/kScreenSizeWidth;
     _page.currentPage = page;
    if (scrollView.contentOffset.x/kScreenSizeWidth == 3){
        scrollView.contentOffset = CGPointMake(0, 0);
        _page.currentPage = 0;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x/kScreenSizeWidth == 3) {
        scrollView.contentOffset = CGPointZero;
        _page.currentPage = 0;
    }
}


-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    [self createTableViewData];
    [self createBannerData];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.0];
}

-(void)stopRefresh{
    if ([self.headView isRefreshing]) {
        [self.headView endRefreshing];
    }
    
    if ([self.footView isRefreshing]) {
        [self.footView endRefreshing];
    }
}

@end
