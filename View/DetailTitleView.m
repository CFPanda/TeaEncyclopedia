//
//  DetailTitleView.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "DetailTitleView.h"
#import "DetailModel.h"
@implementation DetailTitleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
      [self createUI];
        self.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:0.8];
        
    }
    return self;
}

-(void)relayoutWith:(DetailModel *)model{
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(280, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    _title.frame = CGRectMake(20, 10, 280, rect.size.height);
    _title.text = model.title;
    _author.frame = CGRectMake(20, 20+_title.frame.size.height, 60, 12);
    _author.text = model.author;
    _time.frame = CGRectMake(100, 20+_title.frame.size.height,100, 12);
    _time.text = model.create_time;
    
    self.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 30+_time.frame.size.height+_title.frame.size.height);

}

-(void)createUI{
    _title = [[UILabel alloc]init];
    [self addSubview:_title];
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont boldSystemFontOfSize:18];
    _title.numberOfLines = 0;
    
    
    
    _author = [[UILabel alloc]init];
    _author.font = [UIFont boldSystemFontOfSize:12];
    _author.textColor = [UIColor whiteColor];
    [self addSubview:_author];
   
    
    _time = [[UILabel alloc]init];
    _time.font = [UIFont boldSystemFontOfSize:12];
    _time.textColor = [UIColor whiteColor];
    [self addSubview:_time];
    
    
}




@end
