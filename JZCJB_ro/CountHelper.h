//
//  CountHelper.h
//  JZCJB_ro
//
//  Created by ryhx on 16/3/4.
//  Copyright © 2016年 lay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountHelper : NSObject
@property (nonatomic,readonly) NSInteger voteTotal;
@property (nonatomic,readonly) NSInteger menCount;
@property (nonatomic,readonly) NSInteger womenCount;
@property (nonatomic,strong) NSMutableArray * tipsResult;

-(void)addVoteResult:(NSArray *)result;
+(CountHelper *)shareHelper;
@end
