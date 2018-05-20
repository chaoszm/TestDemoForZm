//
//  TripAccelerometerViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripAccelerometerViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <math.h>

@interface TripAccelerometerViewController ()

@property (nonatomic,strong) CMMotionManager *motionManager;

@property (nonatomic,strong) UILabel *vectorLabel;

@property (nonatomic,strong) UIView *testView;

@end

@implementation TripAccelerometerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    _vectorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 230, width, 30)];
    _vectorLabel.font = [UIFont systemFontOfSize:20];
    _vectorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_vectorLabel];
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(width/2, 400, 2, 100)];
    _testView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_testView];
    
    
    
    _motionManager = [[CMMotionManager alloc] init];
    [self startUpdate];
}

-(void)startUpdate{
    if (_motionManager && _motionManager.isAccelerometerAvailable) {
        _motionManager.accelerometerUpdateInterval = 0.1;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        __weak typeof(self) weakSelf = self;
        [_motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            NSString *accelerometerString;
            if (error) {
                [weakSelf.motionManager stopAccelerometerUpdates];
                accelerometerString = [NSString stringWithFormat:@"acceletererror:%@",error];
            }else{
                accelerometerString = [NSString stringWithFormat:@"x:%.2f,y:%.2f,z:%.2f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z];
                [weakSelf.vectorLabel performSelectorOnMainThread:@selector(setText:) withObject:accelerometerString waitUntilDone:NO];
                
                NSDictionary *dic = @{@"x":@(accelerometerData.acceleration.x),
                                      @"y":@(accelerometerData.acceleration.y),
                                      @"z":@(accelerometerData.acceleration.z)};
                [weakSelf performSelectorOnMainThread:@selector(testViewTransitionWithVectorContext:) withObject:dic waitUntilDone:NO];
            }
        }];
    }else{
        self.vectorLabel.text = @"该设备没有加速器";
    }
}

-(void)endUpdate{
    [_motionManager stopAccelerometerUpdates];
    _motionManager = nil;
}

-(void)testViewTransitionWithVectorContext:(NSDictionary *)dic{
    if (dic[@"x"] && dic[@"y"] && dic[@"z"]) {
        [self testViewTransitionWithVectorX:[dic[@"x"] floatValue] y:[dic[@"y"] floatValue] z:[dic[@"z"] floatValue]];
    }
}


-(void)testViewTransitionWithVectorX:(float)x y:(float)y z:(float)z{
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    CGRect originFrame = CGRectMake(width/2, 400, 2, 100);
    _testView.frame = originFrame;
    
    CALayer *layer = _testView.layer;
    layer.anchorPoint = CGPointMake(0, 0);
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    
    [UIView animateWithDuration:0.1 animations:^{
        double angle = [self getAngleBetweenX1:0 y1:-1 x2:x y2:y];
        CATransform3D transform = CATransform3DRotate(rotationAndPerspectiveTransform, angle * M_PI / 180.0f, 0.0f, 0.0f, 1.0f);
        layer.transform = transform;
    }];
    
    
    
}

-(double)getAngleBetweenX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2{
    double cosNum = (x1*x2+y1*y2)/((sqrt(x1*x1+y1*y1))*(sqrt(x2*x2+y2*y2)));
    double angle = acos(cosNum);
    if (x2<0) {
        angle = -angle;
    }
    return -(angle/M_PI)*180.0f;
}


@end
