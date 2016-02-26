//
//  DataBaseDetailTool.m
//  TeaEncyclopedia
//
//  Created by motion on 15/2/18.
//  Copyright (c) 2015年 duanchuanfen. All rights reserved.
//

#import "DataBaseDetailTool.h"
#import "DetailModel.h"
@implementation DataBaseDetailTool
+(instancetype)shareTool{
    static DataBaseDetailTool *tool = nil;
    @synchronized(self){
        if (tool == nil) {
            tool = [[DataBaseDetailTool alloc]init];
        }
    }
    return tool;
}

-(instancetype)init{
    if ([super init]) {
        [self createDataBase];
    }
    return self;
}

-(void)createDataBase{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/detail.db",NSHomeDirectory()];
    _dataBase = [[FMDatabase alloc]initWithPath:path];
    if ([_dataBase open]) {
        NSLog(@"数据库创建成功!");
        [self createTable];
    }else {
        NSLog(@"数据库创建失败...");
    }
    
    
}


-(void)createTable{
    
   NSString *createTableSql = @"create table if not exists detail(author varchar(256),source varchar(256),ID varchar(256),title varchar(256),weiboUrl varchar(256),create_time varchar(256))";
    
    BOOL flag = [_dataBase executeUpdate:createTableSql];
    if (flag) {
        NSLog(@"创建表格成功!");
    }else {
        NSLog(@"创建表格失败!");
    }
  
}



//insert a Data
-(BOOL)insertDataWithModel:(DetailModel *)model{
    NSString *insertSql = @"insert into detail(author,source,ID,title,weiboUrl,create_time)values(?,?,?,?,?,?)";
    BOOL flag = [_dataBase executeUpdate:insertSql,model.author,model.source,model.ID,model.title,model.weiboUrl,model.create_time];
    
    if (flag) {
        NSLog(@"数据插入成功!");
        return flag;
    }
    
    return NO;
    
    
}

//查询所有数据
-(NSArray *)selectAllData{
    NSString *selectSql = @"select * from detail";
    
    FMResultSet *set = [_dataBase executeQuery:selectSql];
    NSMutableArray *mrr = [NSMutableArray array];
    while ([set next]) {
        DetailModel *model = [[DetailModel alloc]init];
        NSDictionary *dict = [set resultDictionary];
        [model setValuesForKeysWithDictionary:dict];
        [mrr addObject:model];
    }
    
    return mrr;
}

@end
