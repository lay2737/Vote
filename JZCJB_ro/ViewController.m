//
//  ViewController.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/3.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "ViewController.h"
#import "Question_ViewController.h"
#import "Result_ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)start:(id)sender {
    [self presentViewController:[[Question_ViewController alloc] init] animated:YES completion:nil];
}
- (IBAction)result:(id)sender {
    [self presentViewController:[[Result_ViewController alloc] init] animated:YES completion:nil];
}

@end
