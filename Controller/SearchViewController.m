//
//  SearchViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/17.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "CollectionTableViewController.h"
#import "SearchResultViewController.h"
#import "RecordTableViewController.h"

#import "CopyrightinformationController.h"
#import "FeedbackViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *sectionOneArray;
@property(nonatomic,strong)NSArray *sectionTwoArray;
@property(nonatomic,strong)UITextField *textField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _sectionOneArray = @[@"收藏夹",@"访问记录"];
    _sectionTwoArray = @[@"版权信息",@"意见反馈"];
    [self createNavigation];
    [self createTableView];
    [self createSearchView];
    
}




#pragma mark - 创建控件

-(void)createNavigation{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"茶百科";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:22],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    
    UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftButton setImage:[UIImage imageNamed:@"searchbackbtn"] forState:(UIControlStateNormal)];
    [leftButton addTarget:self action:@selector(clickLeftBtn) forControlEvents:(UIControlEventTouchUpInside)];
    leftButton.frame = CGRectMake(0, 0, 45, 45);
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightButton setImage:[UIImage imageNamed:@"righttopbutton"] forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(clickRightBtn) forControlEvents:(UIControlEventTouchUpInside)];
    rightButton.frame = CGRectMake(0, 0, 53, 45);

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;

}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,184, kScreenSizeWidth,kScreenSize.height-184)  style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)createSearchView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, 120)];
    [self.view addSubview:view];
    
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, 220*(kScreenSizeWidth/320.0f), 40)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"请输入搜索内容";
    _textField.delegate = self;
    
    [view addSubview:_textField];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"gosearch"] forState:(UIControlStateNormal)];
    button.frame = CGRectMake(240*(kScreenSizeWidth/320.0f), 20, 70, 40);
    [view addSubview:button];
    [button addTarget:self action:@selector(clickSearchBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 100, 20)];
    label.text=@"热门搜索: 茶";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor=[UIColor blackColor];
    [view addSubview:label];
    

    



}

#pragma mark - 点击进入搜索结果界面
-(void)clickSearchBtn{
    if (_textField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"搜索结果为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        
        [alert addAction:action];
        [self presentViewController:alert animated:NO completion:nil];
        
    }
    
    SearchResultViewController *result = [[SearchResultViewController alloc]init];
    result.keyWord = _textField.text;
    [self.navigationController pushViewController:result animated:NO];
}


#pragma  mark - UI事件

-(void)clickLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickRightBtn{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.05];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = _sectionOneArray[indexPath.row];
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = _sectionTwoArray[indexPath.row];
    }
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 15)];
    view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 15)];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentLeft;
    
    
    if (section == 0) {
        label.text=@"收藏夹";
    }
    
    if (section == 1) {
        label.text=@"关于客户端";
    }
    [view addSubview:label];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //push到收藏夹界面
            CollectionTableViewController *collection = [[CollectionTableViewController alloc]init];
            [self.navigationController pushViewController:collection animated:YES];
            
        }else{
            //push到访问记录界面
            RecordTableViewController *record = [[RecordTableViewController alloc]init];
            [self.navigationController pushViewController:record animated:YES];
        }
    
    }
    
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //push到版权信息界面
            CopyrightinformationController *copy = [[CopyrightinformationController alloc]init];
            [self.navigationController pushViewController:copy animated:YES];
        
        }else{
            //push到意见反馈界面
            FeedbackViewController *feed = [[FeedbackViewController alloc]init];
            [self.navigationController pushViewController:feed animated:YES];
        
        }
    
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UItextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [_textField becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [_textField resignFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}
@end
