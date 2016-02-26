//
//  SearchResultViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/19.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "SearchResultViewController.h"
#import "TeaTableViewCell.h"
#import "CellModel.h"
#import "MMProgressHUD.h"
#define kURLString   @"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.searcListByTitle&page=%d&row=20&search=%@"

#import "AFNetworking.h"
#import "MJRefresh.h"
@interface SearchResultViewController ()<MJRefreshBaseViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString *urlString;

@property(nonatomic,strong)MJRefreshHeaderView *headView;
@property(nonatomic,strong)MJRefreshFooterView *footView;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self.tableView registerClass:[TeaTableViewCell class] forCellReuseIdentifier:@"cell"];
    _page = 1;
    self.title = _keyWord;
    _keyWord = [_keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _urlString = [NSString stringWithFormat:kURLString,_page,_keyWord];
    
    [self requestDataWithUrlStringL:_urlString];
    [self createMJRefresh];
    

}

#pragma mark - 创建MJRefresh

-(void)createMJRefresh{
    _headView = [MJRefreshHeaderView header];
    _headView.scrollView = self.tableView;
    _headView.delegate = self;
    
    _footView = [MJRefreshFooterView footer];
    _footView.scrollView = self.tableView;
    _footView.delegate = self;
}



#pragma mark - 请求数据
-(void)requestDataWithUrlStringL:(NSString *)urlString{
    [MMProgressHUD showWithTitle:@"请稍后" status:@"努力加载中"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
            for (NSDictionary *info in dict[@"data"]) {
                CellModel *model = [[CellModel alloc]init];
                [model setValuesForKeysWithDictionary:info];
                [_dataArray addObject:model];
            
            }
            if (_dataArray.count > 0) {
                [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                [MMProgressHUD dismissWithSuccess:@"加载成功!"];
                [self stopRefresh];
            }
        
        
        }else {
            [self stopRefresh];
            [MMProgressHUD dismissWithError:@"没有数据.."];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:error.localizedDescription];
        [self stopRefresh];
   
    }];



}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   TeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CellModel *model = _dataArray[indexPath.row];
    [cell relayoutCellWithModel:model];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_dataArray[indexPath.row] height];
}

#pragma mark -MJRefreshDelegte
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if (refreshView == _headView) {
        _page = 1;
        [_dataArray removeAllObjects];
    }
    if (refreshView == _footView) {
        _page++;
    }
    
    _urlString = [NSString stringWithFormat:kURLString,_page,_keyWord];
    [self requestDataWithUrlStringL:_urlString];
}

-(void)stopRefresh{
    if ([_headView isRefreshing]) {
        [_headView endRefreshing];
    }
    
    if ([_footView isRefreshing]) {
        [_footView endRefreshing];
    }
}

@end
