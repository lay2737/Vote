//
//  CountHelper.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/4.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "CountHelper.h"
#import "LExtension.h"

@interface CountHelper ()
/**
 *  所有投票数组
 */
@property (nonatomic,strong) NSArray * resultArray;
@end
@implementation CountHelper

+(CountHelper *)shareHelper{
    static CountHelper * helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[CountHelper alloc] init];
    });
    return helper;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _menCount = 0;
        _womenCount = 0;
        [self c];
    }
    return self;
}
-(NSMutableArray *)tipsResult{
    if (_tipsResult==nil) {
        _tipsResult = [[NSMutableArray alloc] init];
        
    }
    return _tipsResult;
}
-(void)addVoteResult:(NSArray *)result{
   
    NSMutableArray * re = [[NSMutableArray alloc] initWithArray:self.resultArray];
    [re addObject:result];
    self.resultArray = re;
    
    [LExtension saveObject:self.resultArray forKey:@"result"];
    
    [self c];
}
-(NSArray *)resultArray{
    if (_resultArray == nil) {
        _resultArray = [LExtension objectForKey:@"result"];
//        if (_resultArray == nil) {
//            _resultArray = [[NSArray alloc] init];
//        }
    }
    return _resultArray;
}
-(NSInteger)voteTotal{
    return  [self.resultArray count];
}
-(void)c{
    //onceVote 每份投票结果集合
    _menCount = 0;
    _womenCount = 0;
    for (NSArray * onceVote in self.resultArray) {
        //第一位代表性别
        NSNumber * gender = [onceVote firstObject];
        [gender isEqual:@(1)]?(_menCount++):(_womenCount++);
        //每一题的选择结果
        for (int i=1; i<onceVote.count; i++) {
            ;
            if (self.tipsResult.count<i) {
                [self.tipsResult addObject:[[NSMutableDictionary alloc] init]];
            }
            NSMutableDictionary * optionsResult = self.tipsResult[i-1];
            
            NSNumber * option = onceVote[i];
            NSInteger count;
            switch ([option integerValue]) {
                case 0:
                    count = [[optionsResult objectForKey:@"A"] integerValue];
                    [optionsResult setObject:@(++count) forKey:@"A"];
                    break;
                case 1:
                    count = [[optionsResult objectForKey:@"B"] integerValue];
                    [optionsResult setObject:@(++count) forKey:@"B"];
                    break;
                case 2:
                    count = [[optionsResult objectForKey:@"C"] integerValue];
                    [optionsResult setObject:@(++count) forKey:@"C"];
                    break;
                    
                default:
                    break;
            }
            [self.tipsResult replaceObjectAtIndex:i-1 withObject:optionsResult];
        }
    }
}

@end
