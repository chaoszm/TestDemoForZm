//
//  TripSearchCameraViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/7/7.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripSearchCameraViewController.h"
#import "TripDeviceManager.h"

@interface TripSearchCameraViewController ()

@property (nonatomic,strong) UILabel *deviceMotionLabel;

@property (nonatomic,strong) UIImageView *locationIconView;

@property (nonatomic,strong) UIImageView *locationIconView2;

@property (nonatomic,strong) CMAttitude *referenceAttitude;

@end

@implementation TripSearchCameraViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    _deviceMotionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 230, width, 300)];
    _deviceMotionLabel.font = [UIFont systemFontOfSize:20];
    _deviceMotionLabel.textAlignment = NSTextAlignmentCenter;
    _deviceMotionLabel.numberOfLines = 0;
    _deviceMotionLabel.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    [self.view addSubview:_deviceMotionLabel];
    
    _locationIconView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 180, 12, 17)];
    _locationIconView.image = [UIImage imageNamed:@"trip_location"];
    [self.view addSubview:_locationIconView];
    
    _locationIconView2 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 180, 36, 51)];
    _locationIconView2.image = [UIImage imageNamed:@"trip_location"];
    [self.view addSubview:_locationIconView2];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf beginHandle];
    });
    
}

-(void)beginHandle{
    
    __weak typeof(self) weakSelf = self;
    [[TripDeviceManager shareInstance] startDeviceMotionWithhandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        [weakSelf performSelectorOnMainThread:@selector(updateDeviceMotionLabel:) withObject:motion waitUntilDone:NO];
    }];
}

-(void)updateDeviceMotionLabel:(CMDeviceMotion *)motion{
    if (!_referenceAttitude) {
        _referenceAttitude = motion.attitude;
    }
    
    NSString *text = [NSString stringWithFormat:@"motion: \n attitude: %@ \n",
                      motion.attitude];
    _deviceMotionLabel.text = text;
    
    double rotation = atan2(motion.gravity.x, motion.gravity.y) - M_PI;
    self.locationIconView.transform = CGAffineTransformMakeRotation(rotation);
    
//    [self test3DRotateWithMotion:motion];
}

-(void)test3DRotateWithMotion:(CMDeviceMotion *)motionData{
    CMDeviceMotion *motion = motionData;
    [motion.attitude multiplyByInverseOfAttitude:_referenceAttitude];

    CMRotationMatrix r = motion.attitude.rotationMatrix;
    CATransform3D t;
    t.m11=r.m11;    t.m12=r.m21;    t.m13=r.m31;    t.m14=0;
    t.m21=r.m12;    t.m22=r.m22;    t.m23=r.m32;    t.m24=0;
    t.m31=r.m13;    t.m32=r.m23;    t.m33=r.m33;    t.m34=0;
    t.m41=0;        t.m42=0;        t.m43=0;        t.m44=1;
    
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = 1.0 / -500;
    t = CATransform3DConcat(t, perspectiveTransform);
    t = CATransform3DConcat(t, CATransform3DMakeScale(1.0, -1.0, 1.0));
    
//    _locationIconView2.layer.anchorPoint = CGPointMake(0.5,0);
    _locationIconView2.layer.transform = t;
}

@end
