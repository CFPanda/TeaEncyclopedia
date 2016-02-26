//
//  DataBaseDetailTool.h
//  TeaEncyclopedia
//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//
#import "FMDatabase.h"
#import <Foundation/Foundation.h>
@class DetailModel;
@interface DataBaseDetailTool : NSObject
@property(nonatomic,strong)FMDatabase *dataBase;


+(instancetype)shareTool;


//insert a Data
-(BOOL)insertDataWithModel:(DetailModel *)model;

//查询一个数据
-(NSArray *)selectAllData;
@end
