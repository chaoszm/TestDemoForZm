//
//  TripShapeLayerViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 2017/5/27.
//  Copyright © 2017年 com.zm. All rights reserved.
//

#import "TripShapeLayerViewController.h"

@interface TripShapeLayerViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGFloat f;
@property (nonatomic, strong) UILabel *label; // 显示用

@end

@implementation TripShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initShapeLayerBoard];
}

- (void)initShapeLayerBoard{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.backgroundColor = [UIColor grayColor];
    // 旋转半圈后面self.shapeLayer.strokeStart = 0这样起点刚好在正下方
    view.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
    
    view.center = self.view.center;
    [self.view addSubview: view];
    
    // 初始化CAShapeLayer
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame = CGRectMake(40, 40, 220, 220);
    layer1.lineWidth = 1.0f; // 边框宽度是1;
    layer1.fillColor = [UIColor lightGrayColor].CGColor;
    layer1.strokeColor = [UIColor redColor].CGColor;
    // 贝塞尔曲线
    UIBezierPath *circlePath1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 220, 220)];
    //让贝塞尔曲线与CAShapeLayer产生联系
    layer1.path = circlePath1.CGPath;
    //添加并显示
    [view.layer addSublayer:layer1];
    // 结果为一个圆形
    
    // 第二个
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(50, 50, 200, 200);//设置shapeLayer的尺寸和位置
    //self.shapeLayer.position = view.center;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 20.0f;
    self.shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    //添加并显示
    [view.layer addSublayer:self.shapeLayer];
    // 结果为一个圆形
    
    // 重点
    // 如果先画一个半圆或者不完整的圆
    self.shapeLayer.strokeStart = 0; // 开始的起点 默认的起点是在最右边 旋转半圈后可以在最下方
    self.shapeLayer.strokeEnd = 0; // 这样就是个半圆 //如果 =0.75 就3/4圆
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.frame = CGRectMake(60, 60, 180, 180);
    layer2.lineWidth = 1.0f;
    layer2.fillColor = [UIColor whiteColor].CGColor;
    layer2.strokeColor = [UIColor redColor].CGColor;
    UIBezierPath *circlePath2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 180, 180)];
    //让贝塞尔曲线与CAShapeLayer产生联系
    layer2.path = circlePath2.CGPath;
    //添加并显示
    [view.layer addSublayer:layer2];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, [UIScreen mainScreen].bounds.size.height / 2 -10, 100, 20)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = [NSString stringWithFormat:@"%.2f%%",self.f * 100];
    [self.view addSubview:self.label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 120, 100, 30)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];

    
    UIView *toastView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x,CGRectGetMaxY(view.frame) +20.f, 30.f, 30.f)];
    toastView.backgroundColor = [UIColor grayColor];
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(toastView.frame.size.height/2, toastView.frame.size.height/2) radius:toastView.frame.size.height/2 startAngle:0 endAngle:M_PI clockwise:YES];
    
    //UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 180, 180)];
    path.lineWidth = 1.f;
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = toastView.bounds;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.path = path.CGPath;
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    //layer.position = CGPointMake(toastView.frame.size.width/2, toastView.frame.size.height/2);
    //layer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view addSubview:toastView];
    [toastView.layer addSublayer:layer];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = FLT_MAX;        // 无限循环
    
    
    [layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

- (void)buttonClick:(UIButton *)button{
    button.userInteractionEnabled = NO; // 关闭交互避免快速点击重复动画
    self.f += 0.1;
    if (self.f > 1) {
        self.f = 0;
    }
    [UIView animateWithDuration:1 animations:^{
        self.shapeLayer.strokeEnd = self.f;
    } completion:^(BOOL finished) {
        button.userInteractionEnabled = YES;
        self.label.text = [NSString stringWithFormat:@"%.2f%%",self.f * 100];
        
    }];
}

@end
