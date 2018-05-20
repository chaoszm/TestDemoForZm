//
//  TripDeviceMotionHandler.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/7/7.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripDeviceMotionHandler.h"
#import "TripDeviceManager.h"
#import "TripSearchCameraViewController.h"

@interface TripDeviceMotionHandler ()

@property (nonatomic,assign) BOOL isAccelerometerUseable;

@property (nonatomic,assign) BOOL isGyroscopeUseable;

@end

@implementation TripDeviceMotionHandler

-(void)beforeHandle:(NSDictionary *)context{
    [super beforeHandle:context];
}

-(BOOL)handles:(NSDictionary *)context{
    if ([[TripDeviceManager shareInstance] isDeviceMotionUseable]) {
        if (context && context[@"fromPage"]) {
            id fromPage = context[@"fromPage"];
            if ([fromPage isKindOfClass:[UIViewController class]]) {
                
                TripSearchCameraViewController *viewController = [[TripSearchCameraViewController alloc] init];
                [((UIViewController *)fromPage).navigationController presentViewController:viewController animated:YES completion:^{
                    
                }];
                return YES;
            }
        }
        return  YES;
    }else{
        return NO;
    }
}

@end
