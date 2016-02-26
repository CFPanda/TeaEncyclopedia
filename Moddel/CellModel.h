//
//  CellModel.h
//  TeaEncyclopedia
//
//  Created by motion on 15/2/16.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#define  kScreenSize [UIScreen mainScreen].bounds.size
#define  kScreenSizeWidth [UIScreen mainScreen].bounds.size.width

@interface CellModel : NSObject

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *wap_thumb;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *desc;

@property(nonatomic,assign)float height;

@end
