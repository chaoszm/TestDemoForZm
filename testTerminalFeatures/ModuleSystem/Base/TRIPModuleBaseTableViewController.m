//
//  TRIPModuleBaseTableViewController.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseTableViewController.h"
#import "TRIPCartBaseEventDelegate.h"
#import "TRIPModuleBaseTableModel.h"
#import "TRIPModuleBaseTableModel.h"
#import "TRIPModuleBaseSectionModel.h"
#import "TRIPModuleBaseCellModel.h"
#import "TRIPCartBaseEngine.h"

static const NSString *kTripCartBaseCellId = @"k_cart_table_cell_id";

@interface TRIPModuleBaseTableViewController ()<UITableViewDelegate, UITableViewDataSource, TRIPListRefreshDelegate,TRIPCartBaseEventDelegate>

//配置Table的参数Model
@property (nonatomic,strong) TRIPModuleBaseTableModel *tableModel;

//listRefresh事件
@property (nonatomic,strong) TRIPCartListRefreshEventBlock refreshBlock;
@property (nonatomic,strong) TRIPCartListRefreshEventBlock loadMoreBlock;

@end

@implementation TRIPModuleBaseTableViewController

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initBaseSubviews];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self cancelAllNativeMessages];
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

#pragma mark - UI
-(void)initBaseSubviews{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                              style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self initListRefresh];
}

-(BOOL)needAddLoadMore{
    return NO;
}

-(BOOL)needAddRefresh{
    return NO;
}

-(void)initListRefresh{
    BOOL needRefresh = [self needAddRefresh];
    BOOL needLoadMore = [self needAddLoadMore];
    
    if (!needRefresh && !needLoadMore) {
        return;
    }
    
    _listRefresh = [[TRIPListRefresh alloc] init];
    _listRefresh.needLoadMore = needLoadMore;
    _listRefresh.needRefresh = needRefresh;
    _listRefresh.nextPage = YES;
    _listRefresh.delegate = self;
    [_listRefresh configureTableview:_tableView];
    [_listRefresh setRefreshPullText:@"下拉刷新" releaseText:@"松开刷新"];
}

#pragma mark TRIPListRefreshDelegate
- (void)listControllerTriggerRefresh {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock();
        }
    });
}

- (void)listControllerTriggerGetMore {
    if (_loadMoreBlock) {
        _loadMoreBlock();
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_listRefresh scrollViewDidScroll:scrollView];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == 0) {
        [_listRefresh scrollViewDidEndScrolling:scrollView];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_listRefresh scrollViewDidEndScrolling:scrollView];
}

#pragma mark TRIPCartBaseEventDelegate
-(NSDictionary *)handleEventWithEventName:(NSString *)eventName context:(NSDictionary *)context{
    //子类重写
    return nil;
}

#pragma mark logic
-(void)setNeedAddRefresh:(BOOL)needAddRefresh{
    _listRefresh.needRefresh = needAddRefresh;
}

-(void)setNeedAddLoadMore:(BOOL)needAddLoadMore{
    _listRefresh.needLoadMore = needAddLoadMore;
}

-(TRIPModuleBaseCellModel *)getCellModelWith:(NSIndexPath *)indexPath{
    TRIPModuleBaseSectionModel *sectionModel = [self getSectionModelWith:indexPath];
    if (!sectionModel) {
        NSInteger row = indexPath.row;
        if (sectionModel.moduleCells && sectionModel.moduleCells.count>0
            && row>=0 && row <sectionModel.moduleCells.count) {
            return sectionModel.moduleCells[row];
        }
    }
    return nil;
}

-(TRIPModuleBaseSectionModel *)getSectionModelWith:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        return _tableModel.moduleSections[section];
    }
    return nil;
}

#pragma mark outsideCall

-(void)configListRefreshEvent:(TRIPCartListRefreshEventBlock)refreshBlock loadMoreEvent:(TRIPCartListRefreshEventBlock)loadMoreBlock{
    if (refreshBlock) {
        _refreshBlock = refreshBlock;
    }
    if (loadMoreBlock) {
        _loadMoreBlock = loadMoreBlock;
    }
}

-(void)configTableModel:(TRIPModuleBaseTableModel *)tableModel{
    _tableModel = tableModel;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRIPModuleBaseCellModel *cellModel = [self getCellModelWith:indexPath];
    if (cellModel) {
        return [TRIPCartBaseEngine heightForView:cellModel.viewName withBizModel:cellModel.cellBizData];
    }
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        TRIPModuleBaseSectionModel *sectionModel = _tableModel.moduleSections[section];
        return [TRIPCartBaseEngine heightForView:sectionModel.sectionHeaderViewName withBizModel:sectionModel.sectionBizData];
    }
    return 0.00001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        TRIPModuleBaseSectionModel *sectionModel = _tableModel.moduleSections[section];
        return [TRIPCartBaseEngine heightForView:sectionModel.sectionFooterViewName withBizModel:sectionModel.sectionBizData];
    }
    return 0.00001f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        TRIPModuleBaseSectionModel *sectionModel = _tableModel.moduleSections[section];
        return [TRIPCartBaseEngine viewForName:sectionModel.sectionHeaderViewName];
    }
    return nil;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_itemList) {
        return _itemList.count;
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<0 || indexPath.row >=_itemList.count) {
        return [[TRIPCartBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTripCartBaseCellId];
    }
    
    TRIPCartTableCellConfigModel *configModel = _itemList[indexPath.row];
    NSString *cellViewName = configModel.viewName;
    if (STRING_IS_EMPTY(cellViewName)) {
        return [[TRIPCartBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTripCartBaseCellId];
    }
    
    NSString *reuseId = [NSString stringWithFormat:@"TRIPCart_%@",cellViewName];
    TRIPCartBaseTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [TRIPCartBaseEngine cartCellForName:cellViewName];
        if (!cell) {
            return [[TRIPCartBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTripCartBaseCellId];
        }
    }
    if ([cell isKindOfClass:[TRIPCartBaseTableViewCell class]]) {
        CGFloat height = [TRIPCartBaseEngine heightForView:configModel.viewName withBizModel:configModel.baseBizModel];
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        cell.bizModel = configModel.baseBizModel;
        cell.delegate = self;
        [cell renderUI];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


@end
