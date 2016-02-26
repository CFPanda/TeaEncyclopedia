//
//  BusinessViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/16.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "BusinessViewController.h"

@interface BusinessViewController ()

@end

@implementation BusinessViewController

- (void)viewDidLoad {
    self.type = 53;
    self.page = 1;
    [super viewDidLoad];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CellModel *model = self.dataArray[indexPath.row];
    [cell relayoutCellWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModel *model = self.dataArray[indexPath.row];
    return model.height;
}



@end
