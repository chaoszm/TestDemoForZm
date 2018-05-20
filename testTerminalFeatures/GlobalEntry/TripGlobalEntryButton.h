//
//  TripGlobalEntryButton.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCallBack)();

@interface TripGlobalEntryButton : UIView

@property (nonatomic,strong) UIButton *entryButton;

@property (nonatomic,strong) UILabel *entryLabel;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)setButtonWithImageName:(NSString *)imageName callBack:(ClickCallBack)callBack;

-(void)setLabelText:(NSString *)text;

@end
