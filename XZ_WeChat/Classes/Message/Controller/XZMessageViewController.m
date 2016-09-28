//
//  XZMessageViewController.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import "XZMessageViewController.h"
#import "XZGroupSearchController.h"
#import "XZMessageCell.h"
#import "XZChatViewController.h"


@interface XZMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation XZMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


- (void)setupUI
{
    self.view.backgroundColor = XZRGB(0xf4f1f1);
    self.tableView.backgroundColor = XZRGB(0xf4f1f1);
    XZGroupSearchController *searchVC    = [[XZGroupSearchController alloc] init];
//    searchVC.delegate                    = self;
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchVC];
    [searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = searchController.searchBar;
    _searchController              = searchController;
    [searchController.searchBar setBarTintColor:BACKGROUNDCOLOR];
    [searchController.searchBar.layer setBorderWidth:0.5f];
    [searchController.searchBar.layer setBorderColor:BACKGROUNDCOLOR.CGColor];
    searchController.dimsBackgroundDuringPresentation = YES;
    self.definesPresentationContext = YES;
    searchController.view.backgroundColor = [UIColor whiteColor];
    searchController.hidesNavigationBarDuringPresentation = YES;
    self.tableView.frame  = CGRectMake(0,0, self.view.width, APP_Frame_Height-searchController.searchBar.bottom-8-49);
}

- (void)loadDataSource
{
    XZGroup *group = [[XZGroup alloc] init];
    group.unReadCount = 2;
    group.gName = @"马云";
    group.lastMsgString = @"马化腾你等着!";
    [self.dataArray addObject:group];
}



#pragma mark - tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZMessageCell *cell = [XZMessageCell cellWithTableView:tableView];
    if (indexPath.row == self.dataArray.count - 1) {
        [cell setBottomLineStyle:CellLineStyleNone];
    }
    else {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    cell.group = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67.0;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *topTitle ,*readTitle;
    XZGroup *group  = self.dataArray[indexPath.row];
    topTitle  = group.isTop ? @"取消置顶" : @"置顶";
    readTitle = group.unReadCount ? @"标为已读" : @"标为未读";
    //设置删除按钮
    UITableViewRowAction * deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [self deleteLocalGroup:indexPath];
    }];
    //置顶
    UITableViewRowAction * topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:topTitle handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [self setTopCellWithIndexPath:indexPath currentTop:group.isTop];
    }];
    //标记已读
    UITableViewRowAction * collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:readTitle handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [self markerReadWithIndexPath:indexPath currentUnReadCount:group.unReadCount];
    }];
    collectRowAction.backgroundColor = [UIColor grayColor];
    topRowAction.backgroundColor     = [UIColor orangeColor];
    return  @[deleteRowAction,topRowAction,collectRowAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZGroup *group               = self.dataArray[indexPath.row];
    XZChatViewController *chatVc = [[XZChatViewController alloc] init];
    chatVc.group                 = group;
    [self.navigationController pushViewController:chatVc animated:YES];
}





#pragma mark - setter and getter

- (UITableView *)tableView
{
    if (nil == _tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}



@end
