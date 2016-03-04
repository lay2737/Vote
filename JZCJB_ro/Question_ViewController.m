//
//  Question_ViewController.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/3.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "Question_ViewController.h"
#import "Result_ViewController.h"
#import "CountHelper.h"
#import "LExtension.h"
@interface Question_ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
//@property (nonatomic,strong) NSArray * qArray;

@end

@implementation Question_ViewController
{
    UIView * maleView;
    UIView * femaleView;
    NSInteger gender;
    NSArray * qArray;
    NSInteger questionIndex;
    NSMutableArray * resultArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *shopListPath = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    qArray = [[NSArray alloc]initWithContentsOfFile:shopListPath];
    resultArray = [[NSMutableArray alloc] init];
    
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
    //[self.tableView registerNib:[UINib nibWithNibName:@"OptionsCell" bundle:nil] forCellReuseIdentifier:@"start_Cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"start_Cell"];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(releaseVote)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(cancel)];
}
-(void)configLoadView{
    maleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW/2, kMainScreenH)];
    [self.view addSubview:maleView];
    maleView.userInteractionEnabled = YES;
    maleView.backgroundColor = R_G_B_16(0x4CCCD0);
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGender:)];
    [maleView addGestureRecognizer:tap1];
    
    femaleView = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenW/2, 0, kMainScreenW/2, kMainScreenH)];
    femaleView.userInteractionEnabled = YES;
    [self.view addSubview:femaleView];
    femaleView.backgroundColor = R_G_B_16(0xFF6778);
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGender:)];
    [femaleView addGestureRecognizer:tap2];
}
-(void)selectGender:(UITapGestureRecognizer *)tap{
    if ([tap.view isEqual:maleView]) {
        gender = 1;
    }else{
        gender = 0;
    }
    [resultArray addObject:@(gender)];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionOverrideInheritedOptions | UIViewAnimationOptionCurveEaseInOut animations:^{
        maleView.sizeWidth = kMainScreenW*gender;
        femaleView.originX = kMainScreenW*gender;
        femaleView.sizeWidth = kMainScreenW*!gender;
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
    [resultArray addObject:@(indexPath.row)];
    questionIndex++;
    if (questionIndex==qArray.count) {
        [[CountHelper shareHelper] addVoteResult:resultArray];
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
    __weak UIAlertController * bAlert = alert;
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"查看统计" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:NO completion:^{

            [self presentViewController:[[Result_ViewController alloc] init] animated:YES completion:^{
                     }];
            }];
        
       
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alert addAction:action];
    [alert addAction:cancel];
    
    UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"撒花"]];
    iv.frame = CGRectMake(0, -50, 100, 100);
  //  iv.center = alert.view.center;
    [alert.view addSubview:iv];
    
    [self presentViewController:alert animated:NO completion:nil];
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


@end
