//
//  ShapeLayerHandler.m
//  testTerminalFeatures
//
//  Created by 邹明 on 2017/5/27.
//  Copyright © 2017年 com.zm. All rights reserved.
//

#import "ShapeLayerHandler.h"
#import "TripShapeLayerViewController.h"

@implementation ShapeLayerHandler

-(BOOL)handles:(NSDictionary *)context{
    if (context && context[@"fromPage"]) {
        id fromPage = context[@"fromPage"];
        if ([fromPage isKindOfClass:[UIViewController class]]) {
            
            TripShapeLayerViewController *cameraViewController = [[TripShapeLayerViewController alloc] init];
            [((UIViewController *)fromPage).navigationController pushViewController:cameraViewController animated:YES];
            return YES;
        }
    }
    return YES;
}

@end
