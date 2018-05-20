//
//  TripTestWebViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/8/4.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "TripTestWebViewController.h"
#import <objc/runtime.h>
#import "TripGlobalEntryWindow.h"

@interface TripTestWebViewController ()<UIWebViewDelegate>

@property (nonatomic ,strong) UIWebView *webView;

@end

@implementation TripTestWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initSubviews];
}

-(void)initSubviews{
//    const NSString *key = @"urlString";
    NSString *urlString = objc_getAssociatedObject(self, &urlKey);
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: _webView];
    _webView.delegate = self;

    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:request];
}

@end
