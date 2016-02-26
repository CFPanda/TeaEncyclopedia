
//
//  BannerModel.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/17.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else{
        [super setValue:value forKey:key];
    }
    
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
