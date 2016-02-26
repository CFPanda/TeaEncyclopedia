//
//  TeaTableViewCell.h
//  iOS SH15231056 duanchuanfen
//
//  Created by motion on 15/1/28.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  kScreenSize [UIScreen mainScreen].bounds.size
#define  kScreenSizeWidth [UIScreen mainScreen].bounds.size.width
@class CellModel;
@class DetailModel;
@interface TeaTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property  (strong,nonatomic) UILabel *nickNameLabel;

@property (strong, nonatomic)UIImageView *iconImage;


- (void)relayoutCellWithModel:(CellModel *)model;


- (void)relayoutWithModel:(DetailModel *)model;







@end
