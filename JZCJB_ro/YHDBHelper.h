//
//  YHDBHelper.h
//
//  Created by yh on 15/10/13.
//  Copyright © 2015年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"

@interface YHDBHelper : NSObject

@property (nonatomic, retain, readonly) FMDatabaseQueue *dbQueue;


+ (YHDBHelper *)shareInstance;

+ (NSString *)dbPath;

@end
