//
//  CellModel.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/16.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "CellModel.h"
#define kFont (13*[UIScreen mainScreen].bounds.size.width)/320.0f
@implementation CellModel

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else{
        [super setValue:value forKey:key];
    }
    
    if ([key isEqualToString:@"description"]) {
        _desc = value;
    }else{
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (float)height{
    
    float height = 10 + 10 + 12 + 10;
    NSString *title = self.title;
    CGRect rect = [title boundingRectWithSize:CGSizeMake(kScreenSizeWidth-100, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFont]} context:nil];
    height += rect.size.height;
    return height;
}

@end


