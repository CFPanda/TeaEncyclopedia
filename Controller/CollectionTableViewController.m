//
//  CollectionTableViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/19.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "TeaTableViewCell.h"
#import "DataBaseDetailTool.h"
#import "CellModel.h"
#import "DetailViewController.h"
#import "DetailModel.h"

@interface CollectionTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *array = [[DataBaseDetailTool shareTool] selectAllData];
    [_dataArray addObjectsFromArray:array];
    [self.tableView registerClass:[TeaTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"我的收藏";
    
    
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
    
    //刷新数据
    DetailModel *model = _dataArray[indexPath.row];
    [cell relayoutWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_dataArray[indexPath.row] height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detail = [[DetailViewController alloc]init];
    DetailModel *model = _dataArray[indexPath.row];
    detail.ID = model.ID;
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
