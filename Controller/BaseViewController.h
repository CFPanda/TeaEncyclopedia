//
//  BaseViewController.h
//  TeaEncyclopedia
//
//  Created by motion on 15/2/16.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CellModel.h"
#import "TeaTableViewCell.h"
#import "MJRefresh.h"
#import "MMProgressHUD+Animations.h"
#define kUrlString @"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.getListByType&type=%d&page=%d&row=15"

#import "DetailViewController.h"

@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,copy)void(^Selectpush)(CellModel *model);

@property(nonatomic,assign)int type;
@property(nonatomic,assign)int page;


@property(nonatomic,strong)MJRefreshHeaderView *headView;
@property(nonatomic,strong)MJRefreshFooterView *footView;
@property(nonatomic,strong)NSMutableArray *recordArry;
-(void)requestWithUrlString:(NSString *)urlString;
-(void)requestSucessWithInfo:(NSDictionary *)info;
-(void)requestFailedWithError:(NSString *)error;

-(void)addSelectpush:(void (^)(CellModel *model))Selectpush;


@property(nonatomic,copy)void(^Tappush)(NSString *link);

-(void)addTappush:(void (^)(NSString *link))Tappush;
@end
