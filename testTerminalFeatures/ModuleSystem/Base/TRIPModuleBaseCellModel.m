//
//  TRIPModuleBaseCellModel.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseCellModel.h"

@implementation TRIPModuleBaseCellModel

-(instancetype)init{
    if (self = [super init]) {
        _isFirstCell = NO;
        _isLaseCell = NO;
    }
    return self;
}

@end
