//
//  DetailModel.h
//  TeaEncyclopedia


//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#define  kFont (13*[UIScreen mainScreen].bounds.size.width)/320.0f
@interface DetailModel : NSObject
@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weiboUrl;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *wap_content;

@property(nonatomic,assign)float height;
@end
