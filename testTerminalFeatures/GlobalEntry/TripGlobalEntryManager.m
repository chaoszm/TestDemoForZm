//
//  TripGlobalEntryManager.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripGlobalEntryManager.h"
#import "TripGlobalEntryWindow.h"

@interface TripGlobalEntryManager ()

@property (nonatomic,strong) TripGlobalEntryWindow *entryWindow;

@end

@implementation TripGlobalEntryManager

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)shareInstance {
    static dispatch_once_t once;
    static TripGlobalEntryManager *instance;
    dispatch_once(&once, ^{
        instance = [[TripGlobalEntryManager alloc] init];
    });
    return instance;
}

-(void)generateNewWindowWithFrame:(CGRect)frame{
    if (!_entryWindow) {
        _entryWindow = [[TripGlobalEntryWindow alloc] initWithFrame:frame];
        [_entryWindow makeKeyAndVisible];
    }
}

-(void)resignEntryWindow{
    if (_entryWindow) {
        [_entryWindow resignKeyWindow];
        _entryWindow.hidden = YES;
        _entryWindow = nil;
    }
}

@end
