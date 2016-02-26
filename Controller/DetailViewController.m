//
//  DetailViewController.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "DetailModel.h"
#import "DetailTitleView.h"
#import "DataBaseDetailTool.h"
@interface DetailViewController ()<UIWebViewDelegate>


@property(nonatomic,strong)DetailModel *model;
@property(nonatomic,strong)DetailTitleView *tView;
@property(nonatomic,strong)DataBaseDetailTool *tool;

@property(nonatomic,strong)UILabel *collectonLable;
@property(nonatomic,strong)NSString *urlString;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
     _model = [[DetailModel alloc]init];
     _tView = [[DetailTitleView alloc]initWithFrame:CGRectMake(0, 0,kScreenSizeWidth,80)];
    [_backView addSubview:_tView];
    _tool = [DataBaseDetailTool shareTool];
    _urlString = [NSString stringWithFormat:kURLString,_ID];
    [self getDataWithID:_ID];
    [self createCollectionLabel];
       

}




#pragma mark - 获取数据
-(void)getDataWithID:(NSString *)ID{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:_urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!= nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
            [_model setValuesForKeysWithDictionary:dict[@"data"]];
            if (_model.title != nil) {
                [_tView relayoutWith:_model];
                [self loadWebView];
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
}



#pragma mark - 加载网页的内容视图

-(void)loadWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, _tView.frame.size.height,kScreenSizeWidth,kScreenSize.height-_tView.frame.size.height-70)];
    [_backView addSubview:webView];
    
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    
    if (_model.weiboUrl != nil) {
        [webView loadHTMLString:_model.wap_content baseURL:[NSURL URLWithString:_urlString]];
    }
}
     
     
#pragma mark - 返回 收藏 分享 按钮的的点击事件
- (IBAction)pressBtn:(UIButton *)sender {
    
    //返回按钮
    if (sender.tag == 1000) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //收藏按钮
    if (sender.tag == 1001) {
        
        if (_model.title !=nil) {
            NSArray *array = [_tool selectAllData];
            //判断是否已经收藏过了
            for (DetailModel *model in array) {
                if ([model.ID isEqualToString:_model.ID]) {
                    [self showHasCollection];
                    return;
                }
            }
            
            if ([_tool insertDataWithModel:_model]) {
                [self showCollectionSucess];
            }else{
                [self showCollectionFailed];
            }
        }
    }
    
    
}



#pragma mark - 点击收藏按钮的 操作结果的提醒label

-(void)createCollectionLabel{
    _collectonLable =[[UILabel alloc]initWithFrame:CGRectMake(0,0, 120, 30)];
    //kScreenSize.height/2
    _collectonLable.center = CGPointMake(kScreenSizeWidth/2, kScreenSize.height*3/4.0f);
    _collectonLable.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:0.4];
    _collectonLable.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    _collectonLable.font = [UIFont boldSystemFontOfSize:18];
    _collectonLable.textAlignment = NSTextAlignmentCenter;
    _collectonLable.hidden = YES;
    [self.view addSubview:_collectonLable];
}

-(void)showHasCollection{
    
    _collectonLable.text = @"已经收藏过了";
    _collectonLable.hidden = NO;
    [self performSelector:@selector(removeCollectionLable) withObject:nil afterDelay:2.0];
    
}

-(void)showCollectionFailed{
    
    _collectonLable.text = @"收藏失败";
    _collectonLable.hidden = NO;
    [self performSelector:@selector(removeCollectionLable) withObject:nil afterDelay:2.0];
    
}


-(void)showCollectionSucess{
    
    _collectonLable.text = @"收藏成功";
    _collectonLable.hidden = NO;
    [self performSelector:@selector(removeCollectionLable) withObject:nil afterDelay:1.0];
    
}

-(void)removeCollectionLable{
    _collectonLable.hidden = YES;
}




@end
