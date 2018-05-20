//
//  TRIPModuleBaseDataService.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/15.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark TBCartEventContext
// 事件上下文
@interface TRIPEventContext : NSObject
@property(nonatomic, weak) id pslf;           // 事件所属，weak，可能为nil
@property(nonatomic, strong) id data;           // 事件数据
@property(nonatomic, copy) void (^callback)(id);   // callback

//有参数上下文
+ (instancetype)contextWithPslf:(id)pslf data:(id)data callback:(void (^)(id param))callback;

//无参数上下文
+ (instancetype)contextWithPslf:(id)pslf;

@end




typedef BOOL (^TRIPEventBlock)(TRIPEventContext *context);

#pragma mark TRIPModuleBaseDataService

@interface TRIPModuleBaseDataService : NSObject

//处理action的方法，由子类实现，实现的时候最好调用一下super
-(void)handleEventWithName:(NSString *)name context:(TRIPEventContext *)context;

//注册事件,注册的时候会同时在DispatchManager中注册本dataService
-(void)registerEventWithName:(NSString *)eventName callback:(TRIPEventBlock)callbackBlock;

//获取指定Name的block回调
- (TRIPEventBlock)eventBlockForName:(NSString *)name;

@end
