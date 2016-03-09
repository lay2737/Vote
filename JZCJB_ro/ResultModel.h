//
//  ResultModel.h
//  JZCJB_ro
//
//  Created by ryhx on 16/3/7.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "YHDBModel.h"
#define AtributeName(name) [NSString stringWithFormat:@"%@%ld",@"tip_",name]
extern NSString * HeadName;
@interface ResultModel : YHDBModel
@property (nonatomic,assign) BOOL gender;
@property (nonatomic,strong) NSString * tip_1;
@property (nonatomic,strong) NSString * tip_2;
@property (nonatomic,strong) NSString * tip_3;
@property (nonatomic,strong) NSString * tip_4;
@property (nonatomic,strong) NSString * tip_5;
@property (nonatomic,strong) NSString * tip_6;
@property (nonatomic,strong) NSString * tip_7;
@property (nonatomic,strong) NSString * tip_8;



+(void)creatAttribute:(char *)name;
-(void)setKey:(NSString *)key value:(NSString *)value;
-(id)get:(NSString*)key;
+(NSInteger)totalCount;
+(NSInteger)menCount;
+(NSInteger)womenCount;
@end
