//
//  TRIPModuleBaseTableViewController.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

@class TRIPModuleBaseTableModel;
#import <UIKit/UIKit.h>

typedef UITableViewCell *(^TRIPCartGenerateCellBlock)(UITableView *tableView,NSIndexPath *indexPath);
typedef CGFloat(^TRIPCartCalculateHeightBlock)(UITableView *tableView,NSIndexPath *indexPath);
typedef NSInteger(^TRIPCartCellNumBlock)(UITableView *tableView,NSInteger section);
typedef void(^TRIPCartListRefreshEventBlock)();


@interface TRIPModuleBaseTableViewController : UIViewController

//UI
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TRIPListRefresh *listRefresh;

//是否需要下拉刷新、上拉加载,默认都是NO，如果不重写，但是又调用了configListRefreshEvent，会自动设置对应为YES
-(BOOL)needAddRefresh;
-(BOOL)needAddLoadMore;

/**
 *  配置下拉刷新事件
 *
 *  @param refreshBlock  下拉刷新触发的事件
 *  @param loadMoreBlock 上拉加载触发的事件
 */
-(void)configListRefreshEvent:(TRIPCartListRefreshEventBlock)refreshBlock
                loadMoreEvent:(TRIPCartListRefreshEventBlock)loadMoreBlock;

/**
 *  设置显示tableView的数据
 *
 *  @param cellModels TRIPCartTableCellConfigModel的集合
 */
-(void)configTableModel:(TRIPModuleBaseTableModel *)tableModel;

@end
