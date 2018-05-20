//
//  TRIPDispatchManager.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/13.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRIPModuleBaseDataService.h"

@interface TRIPDispatchManager : NSObject

+(instancetype)shareInstance;

//注册
-(void)registerEventName:(NSString *)eventName
         withDataService:(TRIPModuleBaseDataService *)dataService;

//注销DataService,可以在某个时间段手动注销，也可以在业务线dataService被销毁的时候TRIPDispatchManager中引用自动被销毁
-(void)logoutDataService:(TRIPModuleBaseDataService *)dataService;

//注销某个DataService的之前注册的某个Action
-(void)logoutEvent:(NSString *)eventName
   withDataService:(TRIPModuleBaseDataService *)dataService;

//将事件分发到已注册的dataService中
-(void)dispatchToRegisterDataServiceWithAction:(NSString *)eventName
                                       context:(TRIPEventContext *)context;

//将事件分发到指定的dataService中
-(void)dispatchActionEvent:(NSString *)eventName
                   context:(TRIPEventContext *)context
             toDataService:(TRIPModuleBaseDataService *)dataService;

@end
