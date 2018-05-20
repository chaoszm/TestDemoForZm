//
//  TripGlobalEntryHandler.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripGlobalEntryHandler.h"
#import "TripGlobalEntryTestViewController.h"

@implementation TripGlobalEntryHandler

-(void)beforeHandle:(NSDictionary *)context{
    [super beforeHandle:context];
}

-(BOOL)handles:(NSDictionary *)context{
    TripGlobalEntryTestViewController *viewController = [[TripGlobalEntryTestViewController alloc] init];
    if (context && context[@"fromPage"]) {
        id fromPage = context[@"fromPage"];
        if ([fromPage isKindOfClass:[UIViewController class]]) {
            [((UIViewController *)fromPage).navigationController pushViewController:viewController animated:YES];
        }
    }
    return YES;
}

@end
