//
//  TeaTableViewCell.m
//  iOS SH15231056 duanchuanfen
//
//  Created by motion on 15/1/28.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "TeaTableViewCell.h"
#import "CellModel.h"
#import "DetailModel.h"
#import "UIImageView+WebCache.h"
#define kFont (13*[UIScreen mainScreen].bounds.size.width)/320.0f
@implementation TeaTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 220, 20)];
    
     [self.contentView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:kFont];
    
    
    _titleLabel.numberOfLines = 0;
    
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, 40, 12)];
    _authorLabel.font = [UIFont systemFontOfSize:12];
    _authorLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_authorLabel];
    
    _nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 40, 60, 12)];
     _nickNameLabel.font = [UIFont systemFontOfSize:12];
    _nickNameLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_nickNameLabel];

    
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 40, 60, 12)];
    [self.contentView addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    
    _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenSizeWidth-100+15+10, 10, 60, 42)];
    [self.contentView addSubview:_iconImage];
}


- (void)relayoutCellWithModel:(CellModel *)model
{
    NSString *title =  model.title;
    CGRect rect = [title boundingRectWithSize:CGSizeMake(kScreenSizeWidth-100, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFont]} context:nil];
    
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(15, 10, kScreenSizeWidth-100, rect.size.height);
    
    _authorLabel.text = model.source;
    _authorLabel.frame = CGRectMake(15, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10, 40, 12);
    
    _nickNameLabel.text = model.nickname;
    _nickNameLabel.frame = CGRectMake(65, _authorLabel.frame.origin.y, 60, 12);

    
    _timeLabel.text = model.create_time;
    _timeLabel.frame = CGRectMake(135, _authorLabel.frame.origin.y, 100, 12);
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.wap_thumb] placeholderImage:[UIImage imageNamed:@"defaultcovers"]];
    _iconImage.center = CGPointMake(_iconImage.center.x, model.height/2);
}


- (void)relayoutWithModel:(DetailModel *)model
{
    NSString *title =  model.title;
    CGRect rect = [title boundingRectWithSize:CGSizeMake(kScreenSizeWidth-100, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(15, 10, kScreenSizeWidth-100, rect.size.height);
    
    _authorLabel.text = model.source;
    _authorLabel.frame = CGRectMake(15, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10, 40, 12);
    
    _nickNameLabel.text = model.author;
    _nickNameLabel.frame = CGRectMake(65, _authorLabel.frame.origin.y, 60, 12);
    
    
    _timeLabel.text = model.create_time;
    _timeLabel.frame = CGRectMake(135, _authorLabel.frame.origin.y, 100, 12);
    
    
    
}

@end
