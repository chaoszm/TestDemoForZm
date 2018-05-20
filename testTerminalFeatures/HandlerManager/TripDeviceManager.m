//
//  TripDeviceManager.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/7/7.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripDeviceManager.h"

@interface TripDeviceManager ()

@property (nonatomic , strong) CMMotionManager *motionManager;

@end

@implementation TripDeviceManager

- (instancetype)init{
    if (self = [super init]) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return self;
}

+ (instancetype)shareInstance {
    static dispatch_once_t once;
    static TripDeviceManager *instance;
    dispatch_once(&once, ^{
        instance = [[TripDeviceManager alloc] init];
    });
    return instance;
}

-(CMMotionManager *)getMotionManager{
    return _motionManager;
}

-(BOOL)isAccelerometerUseable{
    return _motionManager.accelerometerAvailable;
//    if (_motionManager.accelerometerAvailable && _motionManager.accelerometerActive) {
//        return YES;
//    }else{
//        return NO;
//    }
}

-(BOOL)isGyroscopeUseable{
    return _motionManager.gyroAvailable;
//    if (_motionManager.gyroAvailable && _motionManager.gyroActive) {
//        return YES;
//    } else {
//        return NO;
//    }
}

-(BOOL)isDeviceMotionUseable{
    return _motionManager.deviceMotionAvailable;
//    if (_motionManager.deviceMotionAvailable && _motionManager.deviceMotionActive) {
//        return YES;
//    } else {
//        return NO;
//    }
}

-(void)startAccelerometerWithHandler:(CMAccelerometerHandler)handler{
    if ([self isAccelerometerUseable]) {
        _motionManager.accelerometerUpdateInterval = 0.1;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [_motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (handler) {
                handler(accelerometerData,error);
            }
        }];
    }
}

-(void)endAccelerometer{
    [_motionManager stopAccelerometerUpdates];
}

-(void)startGyroscopeWithHandler:(CMGyroHandler)handler{
    if ([self isGyroscopeUseable]) {
        _motionManager.gyroUpdateInterval = 0.1;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [_motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (handler) {
                handler(gyroData,error);
            }
        }];
    }
}

-(void)endGyroscope{
    [_motionManager stopGyroUpdates];
}

-(void)startDeviceMotionWithhandler:(CMDeviceMotionHandler)handler{
    if ([self isDeviceMotionUseable]) {
        _motionManager.deviceMotionUpdateInterval = 0.1;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [_motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (handler) {
                handler(motion,error);
            }
        }];
    }
}

@end
