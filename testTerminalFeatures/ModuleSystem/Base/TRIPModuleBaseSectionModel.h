//
//  TRIPModuleBaseSectionModel.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRIPModuleBaseSectionModel : NSObject

//该Section中所需要的所有cell，
@property (nonatomic,strong) NSMutableArray *moduleCells;

//section的业务数据
@property (nonatomic,strong) id sectionBizData;

//外部设置是否第一个Section的Model，默认为NO
@property (nonatomic,assign) BOOL isFirstSection;

//外部设置是否最后一个Section的Model，默认为NO
@property (nonatomic,assign) BOOL isLaseSection;

@property (nonatomic,strong) NSString *sectionHeaderViewName;

@property (nonatomic,strong) NSString *sectionFooterViewName;

@end
