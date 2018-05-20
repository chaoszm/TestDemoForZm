//
//  MasterViewController.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/6/12.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "MasterViewController.h"
#import "BaseHandlerManager.h"
#import "BaseAnalysableModel.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableInfo];
    
    NSLog(@"+++++++++++++");
    NSLog(@"%@",[UIApplication sharedApplication].windows[0]);
    NSLog(@"+++++++++++++");
    
    NSLog(@"%@",self);
    NSLog(@"+++++++++++++");
    NSLog(@"%@",self.navigationController);
    NSLog(@"+++++++++++++");
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initTableInfo{
    self.objects = [[NSMutableArray alloc] initWithArray:[BaseHandlerManager getHandlerInfoArray]];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *dic = self.objects[indexPath.row];
    if (dic && dic[@"name"]) {
        cell.textLabel.text = dic[@"name"];
        return cell;
    }else{
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <0 && indexPath.row >= self.objects.count ) {
        return;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [[BaseHandlerManager shareInstance] loadHandlerWithName:self.objects[indexPath.row][@"handlerName"] context:@{@"fromPage":self}];
}

@end
