//
//  TripGlobalEntryButton.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripGlobalEntryButton.h"

@interface TripGlobalEntryButton ()

@property (nonatomic,copy) ClickCallBack callBack;

@end

@implementation TripGlobalEntryButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _entryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame))];
        _entryButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_entryButton];
        
        _entryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_entryButton.frame) +3, CGRectGetWidth(_entryButton.frame), 12)];
        _entryLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        _entryLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_entryLabel];
    }
    return self;
}

-(void)setButtonWithImageName:(NSString *)imageName callBack:(ClickCallBack)callBack{
    _callBack = callBack;
    [_entryButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [_entryButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_entryButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    _entryButton.backgroundColor = [UIColor clearColor];
}

-(void)clickButton{
    if (_callBack) {
        _callBack();
    }
}

-(void)setLabelText:(NSString *)text{
    if (_entryLabel) {
        _entryLabel.text = text;
    }
}

@end
