//
//  DetailViewController.h
//  TeaEncyclopedia
//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kURLString @"http://sns.maimaicha.com/api?method=news.getNewsContent&id=%@&apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json"
@interface DetailViewController : UIViewController
@property(nonatomic,assign)NSString * ID;
@property (weak, nonatomic) IBOutlet UIView *backView;

-(void)getDataWithID:(NSString *)ID;
@end
