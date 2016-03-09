//
//  Question_ViewController.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/3.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "Question_ViewController.h"
#import "Result_ViewController.h"
#import "LExtension.h"
#import "ResultModel.h"
@interface Question_ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) ResultModel * model;
@end

@implementation Question_ViewController
{
    UIImageView * maleView;
    UIImageView * femaleView;
    NSInteger gender;
    NSArray * qArray;
    NSInteger questionIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *shopListPath = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    qArray = [[NSArray alloc]initWithContentsOfFile:shopListPath];
    
    //
//        for (NSInteger i=0; i<qArray.count; i++) {
//       // char * a = [AtributeName(i+1) UTF8String];
//        [ResultModel creatAttribute:[AtributeName(i+1) UTF8String]];
//    }
    self.model = [[ResultModel alloc] init];

 [self configLoadView];
}
-(void)configTableView{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenW,kMainScreenH-64) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource= self;
    tableview.tableFooterView = [UIView new];
    tableview.backgroundColor = nil;
    [self.view addSubview:tableview];
    self.tableView = tableview;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"start_Cell"];

}
-(void)configLoadView{
    maleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW/2, kMainScreenH)];

    [self.view addSubview:maleView];
    maleView.userInteractionEnabled = YES;
    maleView.backgroundColor = R_G_B_16(0x4CCCD0);
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGender:)];
    [maleView addGestureRecognizer:tap1];
    
    femaleView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenW/2, 0, kMainScreenW*1.5, kMainScreenH)];

    femaleView.userInteractionEnabled = YES;
    [self.view addSubview:femaleView];
    femaleView.backgroundColor = R_G_B_16(0xFF6778);
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGender:)];
    [femaleView addGestureRecognizer:tap2];
}
-(void)selectGender:(UITapGestureRecognizer *)tap{
    self.model.gender = [tap.view isEqual:maleView];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionOverrideInheritedOptions | UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.model.gender) {
            maleView.sizeWidth = kMainScreenW;
            femaleView.originX = kMainScreenW;
        }else{
            femaleView.originX = 0;
        }
     
    } completion:^(BOOL finished) {
       [self configTableView];
        
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section==0?1:3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       return  [qArray[questionIndex][0] boundingRectWithSize:CGSizeMake(([UIScreen mainScreen].bounds.size.width)-1, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size.height+2*8 +1;
        
    }
    return 60;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"start_Cell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = qArray[questionIndex][indexPath.section];
        
    }else{
        cell.textLabel.text = qArray[questionIndex][indexPath.row+1];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    [self.model setValue:[@(indexPath.row) stringValue] forKey:AtributeName(questionIndex+1)];
    
    questionIndex++;
    if (questionIndex==qArray.count) {
        [self.model save];
        [self alertOverView];
    }else{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.alpha = 0;
        self.tableView.alpha = 1;
         [self.tableView reloadData];
    }];
    }
    NSLog(@"1");
}
-(void)alertOverView{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"谢谢合作" message:nil preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"查看统计" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
            [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:[[Result_ViewController alloc] init] animated:YES completion:nil];
        }];
     
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alert addAction:action];
    [alert addAction:cancel];
    
    UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"撒花"]];
    iv.frame = CGRectMake(30, kMainScreenH/2-150, 100, 100);
    [alert.view addSubview:iv];
  
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


@end
