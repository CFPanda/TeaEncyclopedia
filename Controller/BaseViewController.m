//
//  BaseViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/16.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "BaseViewController.h"

#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self createTableView];
    NSString *urlString = [NSString stringWithFormat:kUrlString,self.type,self.page];
    
    [MMProgressHUD showWithTitle:nil status:@"努力加载中..."];
    
    [self requestWithUrlString:urlString];
    
}

#pragma mark - 创建表格和刷新头尾

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[TeaTableViewCell class] forCellReuseIdentifier:@"cell"];
    _headView = [MJRefreshHeaderView header];
    _headView.delegate = self;
    _headView.scrollView = _tableView;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _footView = [MJRefreshFooterView footer];
    _footView.delegate = self;
    _footView.scrollView = _tableView;
    
    _recordArry = [[NSMutableArray alloc]initWithCapacity:0];
    
}


#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    
    CellModel *model = self.dataArray[indexPath.row];
    [_recordArry addObject:model];
    delegate.recordArray = _recordArry;
    
    _Selectpush(self.dataArray[indexPath.row]);
   
   
}

#pragma mark - 请求数据

-(void)requestWithUrlString:(NSString *)urlString{
    
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject == nil) {
            [self requestFailedWithError:@"没有数据"];
            [MMProgressHUD dismissWithError:@"加载失败~"];
            [self  stopRefresh];
        }else{
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
            [self requestSucessWithInfo:info];
        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [self requestFailedWithError:error.localizedDescription];
         [MMProgressHUD dismissWithError:@"加载失败~"];

        [self stopRefresh];
    }];
}

-(void)requestSucessWithInfo:(NSDictionary *)info{
    if (info != nil) {
        
        if (_page == 1) {
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dic in info[@"data"]) {
            CellModel *model = [[CellModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
        }
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        [MMProgressHUD dismissWithSuccess:@"加载成功~"];
         [self stopRefresh];
    }
 }
-(void)requestFailedWithError:(NSString *)error{
    [MMProgressHUD dismissWithError:@"加载失败~"];

}

#pragma mark - MJRefreshHeaderViewDelegte

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if (refreshView == _headView) {
         _page = 1;
    }
    
    if (refreshView == _footView) {
        _page++;
    }

    [self requestWithUrlString:[NSString stringWithFormat:kUrlString,self.type,self.page]];

}


-(void)stopRefresh{
    if ([_headView isRefreshing]) {
        [_headView endRefreshing];
    }
    
    if ([_footView isRefreshing]) {
        [_footView endRefreshing];
    }

}

-(void)addSelectpush:(void (^)(CellModel *model))Selectpush{
    _Selectpush = Selectpush;
}

-(void)addTappush:(void (^)(NSString *link))Tappush{
    _Tappush = Tappush;
}


@end
