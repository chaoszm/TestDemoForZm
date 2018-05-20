//
//  TRIPDispatchManager.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/13.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TRIPDispatchManager.h"
#import "TRIPModuleBaseDataService.h"

@interface TRIPDispatchManager ()

//key是action，value是dataservice的地址对象的nsMapTable表,结构为@{@"click":@{@"0x123456":id,@"111111":id}}
@property (nonatomic,strong) NSMutableDictionary *actionMap;

@end

@implementation TRIPDispatchManager

//事件从View传出Action,到dispatcher，然后由dispatcher分发事件到对应的dataService,对应的dataService处理Action的数据加工,处理完成数据处理后，可以由View监听对应的数据，View进行相应的改变，也可以由对应的PageController对象处理。
+(instancetype)shareInstance{
    static TRIPDispatchManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TRIPDispatchManager alloc] init];
    });
    return instance;
}

-(instancetype)init{
    if (self = [super init]) {
        _actionMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark -Logic
//注册
-(void)registerEventName:(NSString *)eventName
         withDataService:(TRIPModuleBaseDataService *)dataService{
        [self addToActionMapWithName:eventName
                         dataService:dataService];
}

-(void)addToActionMapWithName:(NSString *)eventName
                  dataService:(TRIPModuleBaseDataService *)dataService{
    if (!eventName || eventName.length<=0 || !dataService) {
        return;
    }
    NSMapTable *serviceList = _actionMap[eventName];
    NSString *dsAdr = [NSString stringWithFormat:@"%p",dataService];
    __weak TRIPModuleBaseDataService *weakDS = dataService;
    if (serviceList && [serviceList isKindOfClass:[NSMapTable class]]) {
        //本身存在，添加进去即可
        @synchronized (serviceList) {
            //防止dataService重复添加导致重复调用的问题
            [serviceList setObject:weakDS forKey:dsAdr];
        }
    }else{
        //本身不存在,需要新建
        NSMapTable *dataServiceList = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                            valueOptions:NSPointerFunctionsWeakMemory];
        [dataServiceList setObject:weakDS forKey:dsAdr];
        _actionMap[eventName] = dataServiceList;
    }
}

-(void)logoutDataService:(TRIPModuleBaseDataService *)dataService{
    if (!dataService) {
        return;
    }
    for (NSMapTable *serviceList in [_actionMap allValues]) {
        if (serviceList && serviceList.count>0) {
            NSString *dsAdr = [NSString stringWithFormat:@"%p",dataService];
            [serviceList removeObjectForKey:dsAdr];
        }
    }
}

//注销某个DataService的之前注册的某个Action
-(void)logoutEvent:(NSString *)eventName
   withDataService:(TRIPModuleBaseDataService *)dataService{
    if (!eventName || eventName.length<=0 || dataService) {
        return;
    }
    NSMapTable *serviceList = _actionMap[eventName];
    if (serviceList && [serviceList isKindOfClass:[NSMapTable class]]) {
        NSString *dsAdr = [NSString stringWithFormat:@"%p",dataService];
        [serviceList removeObjectForKey:dsAdr];
    }
}

//将事件分发到已注册的dataService中
-(void)dispatchToRegisterDataServiceWithAction:(NSString *)eventName
                                       context:(TRIPEventContext *)context{
    if (eventName && eventName.length >0 && _actionMap[eventName]) {
        NSMapTable *serviceList = _actionMap[eventName];
        NSEnumerator *enumerator = serviceList.objectEnumerator;
        TRIPModuleBaseDataService *dataServiceObj = [enumerator nextObject];
        while (dataServiceObj) {
            [dataServiceObj handleEventWithName:eventName context:context];
            dataServiceObj = [enumerator nextObject];
        }
    }
}

//将事件分发到指定的dataService中
-(void)dispatchActionEvent:(NSString *)eventName
                   context:(TRIPEventContext *)context
             toDataService:(TRIPModuleBaseDataService *)dataService{
    if (eventName && eventName.length >0 && dataService) {
        [dataService handleEventWithName:eventName context:context];
    }
}

@end
