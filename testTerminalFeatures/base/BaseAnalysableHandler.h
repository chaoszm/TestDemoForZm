//
//  BaseAnalysableHandler.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseAnalysableHandler : NSObject

//需不需要被加载，默认为YES
@property (nonatomic,assign) BOOL needLoading;

//需不需要在一开始就被加载，默认为YES
@property (nonatomic,assign) BOOL needLoadingWhenStart;


//触发加载
-(void)handlerFireWithContext:(NSDictionary *)context;


-(void)beforeHandle:(NSDictionary *)context;

-(void)afterHandle:(NSDictionary *)context;

/**
 *  由子类实现，子类具体的处理逻辑在此实现
 *
 *  @param context 上个页面带入的入参
 *
 *  @return 是否被处理
 */
-(BOOL)handles:(NSDictionary *)context;

@end
