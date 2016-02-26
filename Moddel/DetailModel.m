//
//  DetailModel.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
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
