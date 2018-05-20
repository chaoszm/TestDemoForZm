//
//  TripAccelerometerHandler.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripAccelerometerHandler.h"
#import <CoreMotion/CoreMotion.h>
#import "TripAccelerometerViewController.h"

@interface TripAccelerometerHandler ()

@property (nonatomic,assign) BOOL isAccelerometerUseable;

@end

@implementation TripAccelerometerHandler

-(void)beforeHandle:(NSDictionary *)context{
    [super beforeHandle:context];
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    if (motionManager && motionManager.isAccelerometerAvailable) {
        _isAccelerometerUseable = YES;
    }
}

-(BOOL)handles:(NSDictionary *)context{
    if (!_isAccelerometerUseable) {
        return NO;
    }
    
    if (_isAccelerometerUseable) {
        if (context && context[@"fromPage"]) {
            id fromPage = context[@"fromPage"];
            if ([fromPage isKindOfClass:[UIViewController class]]) {
                
                TripAccelerometerViewController *viewController = [[TripAccelerometerViewController alloc] init];
                [((UIViewController *)fromPage).navigationController pushViewController:viewController animated:YES];
                return YES;
            }
        }
    }
    return NO;
}

@end
