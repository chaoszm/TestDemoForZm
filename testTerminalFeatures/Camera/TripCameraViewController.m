//
//  TripCameraViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripCameraViewController.h"

@interface TripCameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>



@end

@implementation TripCameraViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *picker = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
    picker.backgroundColor = [UIColor yellowColor];
    [picker addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: picker];
    
}

-(void)buttonClicked{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.view.backgroundColor = [UIColor orangeColor];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

@end
