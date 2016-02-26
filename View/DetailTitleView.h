//
//  DetailTitleView.h
//  TeaEncyclopedia
//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;
@interface DetailTitleView : UIView
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *author;
@property(nonatomic,strong)UILabel *time;

-(void)relayoutWith:(DetailModel *)model;
@end
