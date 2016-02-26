//
//  RecordTableViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/22.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "RecordTableViewController.h"
#import "TeaTableViewCell.h"
#import "AppDelegate.h"
#import "CellModel.h"
#import "DetailViewController.h"
@interface RecordTableViewController ()
@property(nonatomic,strong)id delegte;
@end

@implementation RecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TeaTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    
    
    return delegate.recordArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    CellModel *model = delegate.recordArray[indexPath.row];
    [cell relayoutCellWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    CellModel *model = delegate.recordArray[indexPath.row];

    return model.height;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    CellModel *model = delegate.recordArray[indexPath.row];
    detail.ID = model.ID;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
