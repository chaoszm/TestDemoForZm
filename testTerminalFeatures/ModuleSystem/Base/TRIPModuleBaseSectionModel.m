//
//  TRIPModuleBaseSectionModel.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseSectionModel.h"

@implementation TRIPModuleBaseSectionModel

-(instancetype)init{
    if (self = [super init]) {
        _moduleCells = [[NSMutableArray alloc] init];
        _isFirstSection = NO;
        _isLaseSection = NO;
    }
    return self;
}

@end
