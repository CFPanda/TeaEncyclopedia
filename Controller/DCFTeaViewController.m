//
//  DCFTeaViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/15.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
#import "DCFTeaViewController.h"
#import "SearchViewController.h"
#import "HeadlinesViewController.h"
#import "InformationViewController.h"
#import "BusinessViewController.h"
#import "EncyclopediaViewController.h"
#import "DataViewController.h"
#import "BannerViewController.h"

@interface DCFTeaViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

//记录当前选中的按钮
@property(nonatomic,strong)UIButton *currentBtn;

//存放按钮
@property(nonatomic,strong)NSMutableArray *btnArray;

//tableView
@property(nonatomic,strong)UITableView *tableView;

//数据源
@property(nonatomic,strong)NSMutableArray *dataArray;



@property(nonatomic,strong)UIView *lineView;
@end

@implementation DCFTeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets  = NO;
    self.navigationController.navigationBarHidden = YES;
    [self createButton];
    [self createData];
    [self createTableView];
    
    
}

//TODO:创建导航按钮
-(void)createButton{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
   
    _lineView= [[UIView alloc]initWithFrame:CGRectMake(5, 61, kScreenSizeWidth*50/320.0f, 3)];
    _lineView.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    [view addSubview:_lineView];
    
    _btnArray = [[NSMutableArray alloc]initWithCapacity:0];
    UIView *greenLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 2)];
    [self.view addSubview:greenLineView];
    greenLineView.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    
    NSArray *array = @[@"头条",@"新闻",@"日常",@"科普",@"信息"];
    int i ;
    for ( i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:array[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        button.frame = CGRectMake(10+(kScreenSizeWidth*45/320.0f+15)*i, 15, kScreenSizeWidth*45/320.0f, 44);
        [view addSubview:button];
        [button addTarget:self action:@selector(changePage:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 1000+i;
        [_btnArray addObject:button];
        if (i == 0) {
            [button setTitleColor:[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0] forState:(UIControlStateNormal)];
            _currentBtn = button;
            
        }
    
    }
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
    button.frame = CGRectMake(10+(kScreenSizeWidth*45/320.0f+10)*i,15, kScreenSizeWidth*45/320.0f, 44);
    [button addTarget:self action:@selector(changePage:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = 1000+i;
    [view addSubview:button];
    
    
    
}


#pragma mark - 获取数据

-(void)createData{
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *array = @[[HeadlinesViewController class],[InformationViewController class],[BusinessViewController class],[EncyclopediaViewController class],[DataViewController class]];
    
    for (int i = 0; i < 5; i++) {
        Class cls = array[i];
        UIViewController *vC = [[cls alloc]init];
        
        [_dataArray addObject:vC];
    }
    
}

#pragma mark - 创建UI
-(void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc]init];
    [self.view addSubview:_tableView];
    _tableView.pagingEnabled = YES;
    
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
}

#pragma mark - UI事件
-(void)changePage:(UIButton *)button{
    
    NSInteger page = button.tag - 1000;
    
    if ( button.tag != 1005) {
     [_tableView setContentOffset:CGPointMake(0,kScreenSizeWidth*page) animated:YES];
    
    }else{
        SearchViewController *search = [[SearchViewController alloc]init];
        search.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:search animated:YES];
    }
    
}




#pragma mark - tableViewDelegte

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    //刷新cell之前移除其内部的所有自控键
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //刷新数据
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaseViewController *vc = _dataArray[indexPath.row];
    vc.view.frame = cell.bounds;
    
    [vc addSelectpush:^(CellModel *model) {
    DetailViewController *detail = [[DetailViewController alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
        detail.ID = model.ID;
    }];
    
    [vc addTappush:^(NSString *link) {
        BannerViewController *banner = [[BannerViewController alloc]init];
        [self.navigationController pushViewController:banner animated:YES];
        banner.link = link;
    
    
    }];
    
    [cell.contentView addSubview:vc.view];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.width;
}



#pragma mark - ScrollViewDelegte

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //tableView的偏移量
    CGFloat horizonOffset = scrollView.contentOffset.y;
    
   //kScreenSizeWidth*50/320.0f
    //比例
    CGFloat offsetRatio = (NSInteger)horizonOffset%(NSInteger)kScreenSizeWidth/kScreenSizeWidth;
    
    //当前页
    NSInteger curIndex = (horizonOffset+kScreenSizeWidth/2)/kScreenSizeWidth;
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.frame = CGRectMake(5+kScreenSizeWidth*55/320.0f*curIndex, 61, kScreenSizeWidth*50/320.0f, 3);
        
    }];
    _currentBtn = _btnArray[curIndex];
    for (UIButton *button in _btnArray) {
        if (_currentBtn != button) {
            [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:(UIControlStateNormal)];
        }
    }
    
    //过滤滚动结束
    if (curIndex*kScreenSizeWidth != horizonOffset) {
        NSInteger animateIndex = horizonOffset > curIndex*kScreenSizeWidth?curIndex+1:curIndex-1;
        
        if (curIndex > animateIndex) {
            offsetRatio = 1-offsetRatio;
            
        }
        
        UIButton *curBtn =_btnArray[curIndex];
        UIButton *animateBtn = _btnArray[animateIndex];
        [curBtn setTitleColor:[UIColor colorWithRed:0.5*offsetRatio green:0.5 blue:0.5*offsetRatio alpha:1.0] forState:(UIControlStateNormal)];
        [animateBtn setTitleColor:[UIColor colorWithRed:0.5*(1-offsetRatio) green:0.5 blue:0.5*(1-offsetRatio) alpha:1.0] forState:(UIControlStateNormal)];
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView.contentOffset.y ==self.view.frame.size.width*4) {
        SearchViewController *search = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:search animated:YES];

    }
}

#pragma mark - 视图控制器即将出现隐藏导航栏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
