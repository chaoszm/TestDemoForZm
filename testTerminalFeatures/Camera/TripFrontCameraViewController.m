//
//  TripFrontCameraViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/7/7.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripFrontCameraViewController.h"

#define CAMERA_TRANSFORM  1.24299

@interface TripFrontCameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation TripFrontCameraViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.delegate = self;
    self.allowsEditing = NO;
    self.showsCameraControls = NO;
    
    self.toolbarHidden = YES;
    self.navigationBarHidden = YES;
    
//    self.cameraViewTransform = CGAffineTransformScale(self.cameraViewTransform, CAMERA_TRANSFORM, CAMERA_TRANSFORM);

    CGSize screenBounds = [UIScreen mainScreen].bounds.size;
    CGFloat cameraAspectRatio = 4.0f/3.0f;
    CGFloat camViewHeight = screenBounds.width * cameraAspectRatio;
    CGFloat scale = screenBounds.height / camViewHeight;
    self.cameraViewTransform = CGAffineTransformMakeTranslation(0, (screenBounds.height - camViewHeight) / 2.0);
    self.cameraViewTransform = CGAffineTransformScale(self.cameraViewTransform, scale, scale);
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"trip_dismiss"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"trip_dismiss"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self.view bringSubviewToFront:backButton];
}

-(void)popBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
