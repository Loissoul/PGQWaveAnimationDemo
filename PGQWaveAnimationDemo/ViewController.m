//
//  ViewController.m
//  PGQWaveAnimationDemo
//
//  Created by Lois_pan on 17/4/12.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "ViewController.h"
#import "PGQWaveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    PGQWaveView * waveView = [[PGQWaveView alloc] init];
    waveView.backgroundColor = [UIColor grayColor];
    waveView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    [self.view addSubview:waveView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
