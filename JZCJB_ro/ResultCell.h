//
//  ResultCell.h
//  JZCJB_ro
//
//  Created by ryhx on 16/3/7.
//  Copyright © 2016年 lay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *qustion;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *options;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *menOptions;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *womenOptions;
-(void)menCounts:(NSArray *)men womenCounts:(NSArray*)women maxCount:(NSInteger)max;
@end
