//
//  TRIPModuleTestViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/19.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TRIPModuleTestViewController.h"
#import "TRIPModuleBaseDataService.h"
#import "TRIPDispatchManager.h"
#import "TRIPModuleTestView.h"

@interface TRIPModuleTestViewController ()

@property (nonatomic,strong) TRIPModuleBaseDataService *dataService;

@property (nonatomic,strong) TRIPModuleBaseDataService *dataService2;

@end

@implementation TRIPModuleTestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubViews];
    [self bindEvent];
}

-(void)bindEvent{
    _dataService = [[TRIPModuleBaseDataService alloc] init];
    _dataService2 = [[TRIPModuleBaseDataService alloc] init];
    [_dataService registerEventWithName:@"testButtonClick"
                               callback:^BOOL(TRIPEventContext *context) {
                                   if (context.pslf && [context.pslf isKindOfClass:[TRIPModuleTestView class]]) {
                                       TRIPModuleTestView *testButton = (TRIPModuleTestView *)context.pslf;
                                       testButton.backgroundColor = [UIColor greenColor];
                                   }
                                   return YES;
                               }];
    
    __weak typeof(self) weakSelf = self;
    [_dataService2 registerEventWithName:@"selectAllTestButton"
                               callback:^BOOL(TRIPEventContext *context) {
                                   for (UIView *subView in [weakSelf.view subviews]) {
                                       if ([subView isKindOfClass:[TRIPModuleTestView class]]) {
                                           [weakSelf.dataService handleEventWithName:@"testButtonClick" context:[TRIPEventContext contextWithPslf:subView]];
                                       }
                                   }
        return YES;
    }];
}

-(void)dealloc{
//    [[TRIPDispatchManager shareInstance] logoutDataService:_dataService];
//    _dataService = nil;
}

-(void)selectAllButton{
    [[TRIPDispatchManager shareInstance] dispatchToRegisterDataServiceWithAction:@"selectAllTestButton" context:[TRIPEventContext contextWithPslf:nil]];
}

-(void)initSubViews{
    TRIPModuleTestView *testView = [[TRIPModuleTestView alloc] init];
    testView.frame = CGRectMake(20, 100, 200, 40);
    [self.view addSubview:testView];
    testView.backgroundColor = [UIColor grayColor];
    
    
    TRIPModuleTestView *testView2 = [[TRIPModuleTestView alloc] init];
    testView2.frame = CGRectMake(20, 200, 200, 40);
    [self.view addSubview:testView2];
    testView2.backgroundColor = [UIColor grayColor];

    UIButton *selectAllButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
    selectAllButton.backgroundColor = [UIColor grayColor];
    [selectAllButton addTarget:self action:@selector(selectAllButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectAllButton];
    
    
}

@end
