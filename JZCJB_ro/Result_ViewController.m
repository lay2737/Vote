//
//  Result_ViewController.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/4.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "Result_ViewController.h"
#import "CountHelper.h"
#import "LExtension.h"
#import "BingView.h"

@interface Result_ViewController ()
{
    CountHelper * hepler;
}
@end

@implementation Result_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hepler = [CountHelper shareHelper];
   NSArray * a = [hepler tipsResult];
    NSLog(@"%@",a);
    self.view.backgroundColor = R_G_B_16(0xFFFCE2);
    
    BingView * bv = [[BingView alloc] init];
    CGFloat c = hepler.menCount;
    CGFloat b = hepler.voteTotal;
    bv.bl = c/b;
    bv.backgroundColor = R_G_B_16(0xFFFCE2);
    [self.view addSubview:bv];
    bv.layer.cornerRadius = 100;
    bv.layer.masksToBounds= YES;
    bv.frame = CGRectMake(kMainScreenW/2-100, 20, 200, 200);
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenW/2-60, 230, 60, 40)];
    lb.font = [UIFont boldSystemFontOfSize:50];
    lb.text = [@(hepler.voteTotal) stringValue];
    [self.view addSubview:lb];
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenW/2, 250, 80, 20)];
    lb2.font = [UIFont boldSystemFontOfSize:25];
    lb2.text = @"人参与";
    [self.view addSubview:lb2];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil]
    ;}


@end
