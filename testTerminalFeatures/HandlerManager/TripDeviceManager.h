//
//  TripDeviceManager.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/7/7.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface TripDeviceManager : NSObject

+ (instancetype)shareInstance;

-(CMMotionManager *)getMotionManager;

-(BOOL)isAccelerometerUseable;

-(BOOL)isGyroscopeUseable;

-(BOOL)isDeviceMotionUseable;

-(void)startAccelerometerWithHandler:(CMAccelerometerHandler)handler;

-(void)endAccelerometer;

-(void)startGyroscopeWithHandler:(CMGyroHandler)handler;

-(void)endGyroscope;

-(void)startDeviceMotionWithhandler:(CMDeviceMotionHandler)handler;

@end
