//
//  UIWindow+Motion.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "UIWindow+Motion.h"
#import "TripGlobalEntryManager.h"

#define MainScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define MainScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@implementation UIWindow (Motion)

-(BOOL)canBecomeFirstResponder{
    return  YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if (motion == UIEventSubtypeMotionShake) {
        [[TripGlobalEntryManager shareInstance] generateNewWindowWithFrame:CGRectMake(0, (MainScreenHeight-300)/2, MainScreenWidth, 300)];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{

}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{

}

@end
