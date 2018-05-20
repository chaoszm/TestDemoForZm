//
//  TRIPModuleBaseCellModel.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRIPModuleBaseCellModel : NSObject

@property (nonatomic,strong) id cellBizData;

//外部设置是否第一个Cell的Model，默认为NO
@property (nonatomic,assign) BOOL isFirstCell;

//外部设置是否最后一个Cell的Model，默认为NO
@property (nonatomic,assign) BOOL isLaseCell;

@property (nonatomic,strong) NSString *viewName;

@end
