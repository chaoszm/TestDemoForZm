//
//  TRIPModuleSystemHandler.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/13.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TRIPModuleSystemHandler.h"
#import "TRIPModuleTestViewController.h"

@implementation TRIPModuleSystemHandler

-(void)beforeHandle:(NSDictionary *)context{
    [super beforeHandle:context];
}

-(BOOL)handles:(NSDictionary *)context{
    if (context && context[@"fromPage"]) {
        UIViewController *fromPage = context[@"fromPage"];
        TRIPModuleTestViewController *testViewController = [[TRIPModuleTestViewController alloc] init];
        [fromPage.navigationController pushViewController:testViewController animated:YES];
        return YES;
    }
    
    return YES;
}

@end
