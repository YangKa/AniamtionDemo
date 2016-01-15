//
//  ViewController.m
//  TestDemo
//
//  Created by qianzhan on 16/1/15.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "ViewController.h"
#import "YKPopViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //关闭btn
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 60);
    btn.center = self.view.center;
    [btn setTitle:@"打开" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:217/255.0 green:110/255.0 blue:90/255.0 alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)open{
    YKPopViewController *popView = [[YKPopViewController alloc] init];
    [popView popEditViewForVC:self completeBlock:^(BOOL finish) {
        if (finish) {
            NSLog(@"关闭动画");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
