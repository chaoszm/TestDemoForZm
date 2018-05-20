//
//  BaseAnalysableHandler.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "BaseAnalysableHandler.h"

@implementation BaseAnalysableHandler

#pragma mark life circle
-(instancetype)init{
    if (self = [super init]) {
        _needLoading = YES;
        _needLoadingWhenStart = YES;
    }
    return self;
}

-(void)handlerFireWithContext:(NSDictionary *)context{
    [self prepareToRun:context];
    [self handlerRun:context];
    [self afterRunning:context];
}

-(void)prepareToRun:(NSDictionary *)context{
    
    
    [self beforeHandle:context];
}

-(void)handlerRun:(NSDictionary *)context{
    
    [self handles:context];
}

-(void)afterRunning:(NSDictionary *)context{

    [self afterHandle:context];
}


#pragma mark outside get

-(void)beforeHandle:(NSDictionary *)context{
    //由子类实现
}

-(void)afterHandle:(NSDictionary *)context{
    //由子类实现
}

-(BOOL)handles:(NSDictionary *)context{
    //由子类实现
    return NO;
}

@end
