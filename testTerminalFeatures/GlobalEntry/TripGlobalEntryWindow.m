//
//  TripGlobalEntryWindow.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/1.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripGlobalEntryWindow.h"
#import "TripGlobalEntryManager.h"
#import "TripGlobalEntryButton.h"
#import "TripTestWebViewController.h"
#import <objc/runtime.h>

#define MainScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define MainScreenHeight ([[UIScreen mainScreen] bounds].size.height)



typedef void(^ButtonAnimationCompletion)();

static const NSInteger kTripGlobalEntryButtonWidth = 40;

@interface TripGlobalEntryWindow()

@property (nonatomic,strong) NSMutableArray *buttonRectArray;

@property (nonatomic,strong) NSMutableArray *buttonArray;

@property (nonatomic,assign) NSInteger finalOriginX;

@property (nonatomic,assign) NSInteger buttonAnimationCount;

@end

@implementation TripGlobalEntryWindow

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _buttonRectArray = [[NSMutableArray alloc] init];
        _buttonArray = [[NSMutableArray alloc] init];
        
        _finalOriginX = MainScreenWidth - kTripGlobalEntryButtonWidth -10;
        
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 5.0f;
        [self initSubviews];
        __weak TripGlobalEntryWindow *weakSelf = self;
        [self startButtonAnimation:^{
            [weakSelf addAllSubviewsRectInArray];
        }];
    }
    return self;
}

-(void)dealloc{
    _buttonRectArray = nil;
    _buttonArray = nil;
}

-(void)initSubviews{
    __weak typeof(self) weakSelf = self;
    
    TripGlobalEntryButton *entryButton1 = [self gennerateEntryButtonWithTitle:@"迪士尼" ImageName:@"Disney" clickCallBack:^{
        [weakSelf gotoTestWebPageWithUrl:@"http://www.taobao.com"];
    }];
    [self setOrigin:CGPointMake(MainScreenWidth, 0) inView:entryButton1];
    [_buttonArray addObject:entryButton1];
    
    TripGlobalEntryButton *entryButton2 = [self gennerateEntryButtonWithTitle:@"暑期大促" ImageName:@"summer_vacation" clickCallBack:^{
        [weakSelf gotoTestWebPageWithUrl:@"http://www.baidu.com"];
    }];
    [self setOrigin:CGPointMake(MainScreenWidth, 20 + kTripGlobalEntryButtonWidth) inView:entryButton2];
    [_buttonArray addObject:entryButton2];
    
    TripGlobalEntryButton *entryButton3 = [self gennerateEntryButtonWithTitle:@"页面会退" ImageName:@"return_to_last_page" clickCallBack:^{
        [weakSelf goBackLastPage];
    }];
    [self setOrigin:CGPointMake(MainScreenWidth, 40 + 2*kTripGlobalEntryButtonWidth) inView:entryButton3];
    [_buttonArray addObject:entryButton3];
    
    TripGlobalEntryButton *globalEntry = [self gennerateEntryButtonWithTitle:@"回到首页" ImageName:@"home" clickCallBack:^{
        [weakSelf goHomePage];
    }];
    [self setOrigin:CGPointMake(MainScreenWidth, 60 + 3*kTripGlobalEntryButtonWidth) inView:globalEntry];
    [_buttonArray addObject:globalEntry];
    
    TripGlobalEntryButton *foldButton = [self gennerateEntryButtonWithTitle:@"折叠" ImageName:@"fold" clickCallBack:^{
        [weakSelf resign];
    }];
    [self setOrigin:CGPointMake(MainScreenWidth, 80 + 4*kTripGlobalEntryButtonWidth) inView:foldButton];
    [_buttonArray addObject:foldButton];
}

-(void)startButtonAnimation:(ButtonAnimationCompletion)completion{
    __weak typeof(self) weakSelf = self;
    for (UIView *button in _buttonArray) {
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf setViewPosition:button originX:_finalOriginX];
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }
}

-(void)foldButtonsAnimation:(ButtonAnimationCompletion)completion{
    __weak typeof(self) weakSelf = self;
    for (UIView *button in _buttonArray) {
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf setViewPosition:button originX:MainScreenWidth];
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }
}

-(void)setViewPosition:(UIView *)view originX:(NSInteger)originX{
    view.frame = CGRectMake(originX,
                              CGRectGetMinY(view.frame),
                              CGRectGetWidth(view.frame),
                              CGRectGetHeight(view.frame));
}

-(TripGlobalEntryButton *)gennerateEntryButtonWithTitle:(NSString *)title ImageName:(NSString *)imageName clickCallBack:(ClickCallBack)callBack{
    TripGlobalEntryButton *entryButton = [[TripGlobalEntryButton alloc] initWithFrame:CGRectMake(0, 0, kTripGlobalEntryButtonWidth, kTripGlobalEntryButtonWidth)];
    [entryButton setLabelText:title];
    [entryButton setButtonWithImageName:imageName callBack:callBack];
    [self addSubview:entryButton];
    return entryButton;
}

-(UIButton *)gennerateButtonWithImageName:(NSString *)imageName sel:(SEL)selector{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kTripGlobalEntryButtonWidth, kTripGlobalEntryButtonWidth)];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor clearColor];
    [self addSubview:button];
    return button;
}

-(void)setOrigin:(CGPoint)point inView:(UIView *)view{
    view.frame = CGRectMake(point.x, point.y, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
}

-(void)addAllSubviewsRectInArray{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *subviews = [weakSelf subviews];
        if (_buttonRectArray && subviews.count >0) {
            for (UIView *subview in subviews) {
                [weakSelf addRectToArray:subview.frame];
                subview.backgroundColor = [UIColor grayColor];
            }
        }
    });
}

-(void)addRectToArray:(CGRect)rect{
    if (_buttonRectArray) {
        NSString *rectString = NSStringFromCGRect(rect);
        [_buttonRectArray addObject:rectString];
    }
}

-(CGRect)getRectFromArrayAtIndex:(NSInteger)index{
    if (_buttonRectArray && index>=0 && index<_buttonRectArray.count) {
        if (_buttonRectArray[index] && [_buttonRectArray[index] isKindOfClass:[NSString class]]) {
            CGRect rect = CGRectFromString(_buttonRectArray[index]);
            return rect;
        }else{
            return CGRectZero;
        }
    }else{
        return CGRectZero;
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //将不在button点击区域的事件漏出去
    if (_buttonRectArray && _buttonRectArray.count>0) {
        BOOL isInside = NO;
        for (NSString *rectString in _buttonRectArray) {
            CGRect rect = CGRectFromString(rectString);
            if (CGRectContainsPoint(rect, point)) {
                isInside = YES;
                break;
            }
        }
        if (isInside) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

-(UIViewController *)getWindowCurrentViewController:(UIWindow *)window{
    UIViewController *result = nil;
    UIView *frontView = [window.subviews objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }else{
        result = [window rootViewController];
    }
    return result;
}

-(void)resign{
    [self foldButtonsAnimation:^{
        [[TripGlobalEntryManager shareInstance] resignEntryWindow];
    }];
}

-(UINavigationController *)getMainWindowNavigation{
    UIWindow *mainWindow = [UIApplication sharedApplication].windows[0];
    UISplitViewController *splitViewController = (UISplitViewController *)mainWindow.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    return navigationController;
}

-(void)goHomePage{
    UINavigationController *navigationController = [self getMainWindowNavigation];
    [navigationController popToRootViewControllerAnimated:YES];
}

-(void)goBackLastPage{
    UINavigationController *navigationController = [self getMainWindowNavigation];
    [navigationController popViewControllerAnimated:YES];
}

-(void)gotoTestWebPageWithUrl:(NSString *)urlString{
    TripTestWebViewController *testWebPage = [[TripTestWebViewController alloc] init];
    
    objc_setAssociatedObject(testWebPage,&urlKey,urlString,OBJC_ASSOCIATION_RETAIN);
    
    UINavigationController *navigationController = [self getMainWindowNavigation];
    [navigationController pushViewController:testWebPage animated:YES];
}

@end
