//
//  BaseHandlerManager.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "BaseHandlerManager.h"
#import "BaseAnalysableHandler.h"
#import <objc/runtime.h>

@interface BaseHandlerManager ()

//@property (nonatomic,strong) NSMutableArray *handlers;

@property (nonatomic,strong) NSMutableArray *handlerNames;

@end

@implementation BaseHandlerManager

- (instancetype)init{
    if (self = [super init]) {
//        _handlers = [[NSMutableArray alloc] init];
        _handlerNames = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (instancetype)shareInstance {
    static dispatch_once_t once;
    static BaseHandlerManager *instance;
    dispatch_once(&once, ^{
        instance = [[BaseHandlerManager alloc] init];
    });
    return instance;
}

+ (NSArray *)getHandlerInfoArray{
    return @[
             @{@"name":@"摄像头",@"handlerName":@"CameraHandler"},
             @{@"name":@"重力感应",@"handlerName":@""},
             @{@"name":@"陀螺仪",@"handlerName":@""},
             @{@"name":@"加速计",@"handlerName":@"TripAccelerometerHandler"},
             @{@"name":@"环境光传感器",@"handlerName":@""},
             @{@"name":@"距离传感器",@"handlerName":@""},
             @{@"name":@"磁力传感器",@"handlerName":@""},
             @{@"name":@"DeviceMotion",@"handlerName":@"TripDeviceMotionHandler"},
             @{@"name":@"全局入口",@"handlerName":@"TripGlobalEntryHandler"},
             @{@"name":@"组件快速迭代",@"handlerName":@"TRIPModuleSystemHandler"},
             @{@"name":@"ShapeLayer",@"handlerName":@"ShapeLayerHandler"}];
}


- (BOOL)loadHandlerWithName:(NSString *)className context:(NSDictionary *)context{
    BOOL loadSuccess = YES;
    Class class = NSClassFromString(className);
    if (!class && ![class isSubclassOfClass:[BaseAnalysableHandler class]]) {
        return NO;
    }
    
    id instance = [[class alloc] init];
    if ([instance respondsToSelector:@selector(handlerFireWithContext:)]) {
        [instance handlerFireWithContext:context];
        loadSuccess = YES;
    }else{
        loadSuccess = NO;
    }
    
    return loadSuccess;
}

- (void)findAllHandler{
    if (!_handlerNames && _handlerNames.count <= 0) {
        return;
    }
    for (NSString *handlerName in _handlerNames) {
        if (!handlerName && handlerName.length <=0) {
            continue;
        }
        [self loadHandlerWithName:handlerName context:nil];
    }
}

@end
