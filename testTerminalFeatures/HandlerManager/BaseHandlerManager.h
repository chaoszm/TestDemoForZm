//
//  BaseHandlerManager.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseHandlerManager : NSObject

+ (instancetype)shareInstance;

+ (NSArray *)getHandlerInfoArray;

- (BOOL)loadHandlerWithName:(NSString *)className context:(NSDictionary *)context;

-(void)findAllHandler;

@end
