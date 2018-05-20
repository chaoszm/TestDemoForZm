//
//  TRIPModuleTestView.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/20.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TRIPModuleTestView.h"
#import "TRIPDispatchManager.h"

@implementation TRIPModuleTestView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor =[UIColor blackColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTestView)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)clickTestView{
    [[TRIPDispatchManager shareInstance] dispatchToRegisterDataServiceWithAction:@"testButtonClick" context:[TRIPEventContext contextWithPslf:self]];
}

@end
