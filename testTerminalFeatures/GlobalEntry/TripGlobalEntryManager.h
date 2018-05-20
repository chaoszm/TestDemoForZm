//
//  TripGlobalEntryManager.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TripGlobalEntryManager : NSObject

+ (instancetype)shareInstance;

-(void)generateNewWindowWithFrame:(CGRect)frame;

-(void)resignEntryWindow;

@end
