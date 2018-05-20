//
//  TripGlobalEntryTestViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripGlobalEntryTestViewController.h"

@interface TripGlobalEntryTestViewController ()

@end

@implementation TripGlobalEntryTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 100, 50)];
    [button addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

-(void)gotoNext{
    TripGlobalEntryTestViewController *nextController = [[TripGlobalEntryTestViewController alloc] init];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
