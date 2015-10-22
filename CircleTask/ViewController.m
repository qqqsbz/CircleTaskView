//
//  ViewController.m
//  CircleTask
//
//  Created by coder on 15/10/22.
//  Copyright © 2015年 coder. All rights reserved.
//

#import "ViewController.h"
#import "CircleTaskView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CircleTaskView *taskView = [[CircleTaskView alloc] initWithFrame:CGRectMake(85, 200, 150, 150) completeNumber:3 unCompleteNumber:7];
    taskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65f];
    taskView.layer.masksToBounds = YES;
    taskView.layer.cornerRadius  = 15;
    [self.view addSubview:taskView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
