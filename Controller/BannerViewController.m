//
//  BannerViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/19.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "BannerViewController.h"
#define kURLString @"http://sns.maimaicha.com/api?method=news.getNewsContent&id=%@&apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json"
#import "AFNetworking.h"
#import "DetailModel.h"
@interface BannerViewController ()
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)DetailModel *model;
@end

@implementation BannerViewController

- (void)viewDidLoad {
    
[super viewDidLoad];
    _model = [[DetailModel alloc]init];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array = [_link componentsSeparatedByString:@"/"];
    NSString *link = [array lastObject];
    self.navigationController.navigationBar.translucent = NO;
    [self getDataWithID:link];
    [self createNavigation];
    
    
    
    
}

#pragma mark - 获取数据
-(void)getDataWithID:(NSString *)ID{
    _urlString = [NSString stringWithFormat:kURLString,ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:_urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!= nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
            [_model setValuesForKeysWithDictionary:dict[@"data"]];
            if (_model.title != nil) {
               
                [self loadWebView];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
}



#pragma mark - 加载网页的内容视图

-(void)loadWebView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    
    if (_model.weiboUrl != nil) {
        [_webView loadHTMLString:_model.wap_content baseURL:[NSURL URLWithString:_urlString]];
    }
    
    
}

-(void)createNavigation{
    self.title = @"详情";
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

-(void)clickRightBtn{
    
}

-(void)clickLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
