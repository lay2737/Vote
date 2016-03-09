//
//  Result_ViewController.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/4.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "Result_ViewController.h"

#import "LExtension.h"
#import "BingView.h"
#import "ResultModel.h"
#import "ResultCell.h"
@interface Result_ViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * qArray;
}
@property (nonatomic,strong) UICollectionView * collectionView;
@end

@implementation Result_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = R_G_B_16(0x96A0E8);
    NSString *shopListPath = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    qArray = [[NSArray alloc]initWithContentsOfFile:shopListPath];
    if ([ResultModel totalCount]!=0) {
        [self configView];
    }
    BingView * bv = [[BingView alloc] init];
    CGFloat c = [ResultModel menCount];
    CGFloat b = [ResultModel totalCount];
    bv.bl = c/b;
    bv.backgroundColor = R_G_B_16(0xFFFCE2);
    [self.view addSubview:bv];
    bv.layer.cornerRadius = 100;
    bv.layer.masksToBounds= YES;
    bv.frame = CGRectMake(kMainScreenW/2-100, 20, 200, 200);
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenW/2-60, 230, 60, 40)];
    lb.font = [UIFont boldSystemFontOfSize:50];
    lb.text = [@([ResultModel totalCount]) stringValue];
    lb.textColor = R_G_B_16(0xFFFCE2);
    [self.view addSubview:lb];
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenW/2, 250, 80, 20)];
    lb2.font = [UIFont boldSystemFontOfSize:25];
    lb2.text = @"人参与";
    lb2.textColor = R_G_B_16(0xFFFCE2);
    [self.view addSubview:lb2];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil]
    ;
}

-(void)configView{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kMainScreenW, kMainScreenH-280);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 280, kMainScreenW, kMainScreenH-280) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ResultCell"];
    self.collectionView = collectionView;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ResultCell *cell = (ResultCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ResultCell" forIndexPath:indexPath];
    
        cell.qustion.text = qArray[indexPath.row][0];
    for (int i=0; i<3; i++) {
       ((UILabel *)(cell.options[i])).text = qArray[indexPath.row][i+1];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    NSMutableArray * men = [[NSMutableArray alloc] init];
    NSMutableArray * women = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<3;i++) {
        NSString * search = [NSString stringWithFormat:@"where gender=1 and %@=%ld",AtributeName(indexPath.row+1),i];
        [men addObject:@([ResultModel findByCriteria:search].count)];
        
        NSString * search2 = [NSString stringWithFormat:@"where gender=0 and %@=%ld",AtributeName(indexPath.row+1),i];
        [women addObject:@([ResultModel findByCriteria:search2].count)];
        
    }
    [(ResultCell *)cell menCounts:men womenCounts:women maxCount:[ResultModel totalCount]];

}
@end
