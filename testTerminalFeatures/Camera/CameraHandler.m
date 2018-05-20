//
//  CameraHandler.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "CameraHandler.h"
#import <UIKit/UIKit.h>
#import "TripCameraViewController.h"

@interface CameraHandler ()

@property (nonatomic,assign) BOOL isCameraAvailable;

@end

@implementation CameraHandler

-(void)beforeHandle:(NSDictionary *)context{
    if (context && context[@"fromPage"]) {
        id fromPage = context[@"fromPage"];
        if ([fromPage isKindOfClass:[UIViewController class]]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                ((UIViewController *)fromPage).view.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:0.5];
                _isCameraAvailable = YES;
            }else{
                ((UIViewController *)fromPage).view.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:0.5];
                _isCameraAvailable = NO;
            }
        }
    }
    
}

-(BOOL)handles:(NSDictionary *)context{
    if (!_isCameraAvailable) {
        return NO;
    }
    
    if (context && context[@"fromPage"]) {
        id fromPage = context[@"fromPage"];
        if ([fromPage isKindOfClass:[UIViewController class]]) {
            
            TripCameraViewController *cameraViewController = [[TripCameraViewController alloc] init];
            [((UIViewController *)fromPage).navigationController pushViewController:cameraViewController animated:YES];
            return YES;
        }
    }
    return NO;
}

@end
