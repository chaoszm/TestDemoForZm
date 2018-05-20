//
//  TRIPModuleBaseDataService.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/15.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TRIPModuleBaseDataService.h"
#import "TRIPDispatchManager.h"

#pragma mark TRIPEventContext
@implementation TRIPEventContext

+(instancetype)contextWithPslf:(id)pslf data:(id)data callback:(void (^)(id))callback{
    TRIPEventContext *context = [[TRIPEventContext alloc] init];
    context.pslf = pslf;
    context.data = data;
    context.callback = callback;
    return context;
}

//无参数上下文
+ (instancetype)contextWithPslf:(id)pslf{
    TRIPEventContext *context = [[TRIPEventContext alloc] init];
    context.pslf = pslf;
    context.data = nil;
    context.callback = nil;
    return context;
}

@end

#pragma mark TRIPModuleBaseDataService

@interface TRIPModuleBaseDataService ()
@property (nonatomic,strong) NSMutableDictionary *eventMap;
@end

@implementation TRIPModuleBaseDataService

-(instancetype)init{
    if (self = [super init]) {
        _eventMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//处理action的方法，由子类实现，实现的时候最好调用一下super
-(void)handleEventWithName:(NSString *)name context:(TRIPEventContext *)context{
    if (name && _eventMap[name]) {
        TRIPEventBlock block = _eventMap[name];
        block(context);
        if (context.callback) {
            context.callback(context);
        }
    }
}

//注册事件,注册的时候会同时在DispatchManager中注册本dataService
-(void)registerEventWithName:(NSString *)eventName callback:(TRIPEventBlock)callbackBlock{
    //同时在分发器中注册
    [[TRIPDispatchManager shareInstance] registerEventName:eventName withDataService:self];
    
    if (eventName && callbackBlock) {
        _eventMap[eventName] = [callbackBlock copy];
    }
}

//获取指定Name的block回调
- (TRIPEventBlock)eventBlockForName:(NSString *)name{
    if (!name) {
        return nil;
    }
    return _eventMap[name];
}

-(void)dealloc{
//    [[TRIPDispatchManager shareInstance] logoutDataService:self];
}

@end
