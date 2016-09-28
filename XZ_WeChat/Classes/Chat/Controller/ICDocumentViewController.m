//
//  ICDocumentViewController.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/29.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICDocumentViewController.h"
#import "ICFileTool.h"
#import "ICDocumentCell.h"
#import "ICFileScanController.h"

@interface ICDocumentViewController ()<UITableViewDataSource,UITableViewDelegate,ICDocumentCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, copy) NSString *name;

@end

@implementation ICDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupSubviews];
    
    [self loadData];

}



#pragma mark - NAV

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本机文件";
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightButton addTarget:self action:@selector(rightBarButtonClicked)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [rightButton setTitleColor:XZRGB(0x018eb0) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.rightBtn = rightButton;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBarButtonClicked)forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

#pragma mark - Event

- (void)rightBarButtonClicked
{
    if (!self.name) return;
    if ([self.delegate respondsToSelector:@selector(selectedFileName:)]) {
        [self.delegate selectedFileName:self.name];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBarButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadData
{
    NSDirectoryEnumerator * enumer = [[NSFileManager defaultManager] enumeratorAtPath:[ICFileTool fileMainPath]];
    NSString *name;
    while (name = [enumer nextObject]) {
        if ([name isEqualToString:@".DS_Store"]) continue;
        if (![[name pathExtension] isEqualToString:@"DS_Store"]&&[name length]>0) {
            [self.dataArr addObject:name];
        }
    }
    
//    ICLog(@"===%@",[ICFileTool fileMainPath]);
}


#pragma mark - UI

- (void)setupSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-64) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate   = self;
    [self.view addSubview:tableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ICDocumentCell *cell = [ICDocumentCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.name = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ICDocumentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ICFileScanController *scanVC = [[ICFileScanController alloc] init];
    scanVC.filePath              = cell.filePath;
    scanVC.orgName               = cell.name;
    [self.navigationController pushViewController:scanVC animated:YES];
}

#pragma mark - ICDocumentCellDelegate

- (void)selectBtnClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    ICDocumentCell *cell = (ICDocumentCell *)[[button superview] superview];
    NSIndexPath *curIndexPath = [self.tableView indexPathForCell:cell];
    
    for (int row = 0; row < self.dataArr.count; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        if (curIndexPath != indexPath) {
            ICDocumentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.selectBtn.selected = NO;
        }
    }
    
    self.name = cell.name;
    button.selected = !button.selected;
    if (button.selected) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self.rightBtn setTitleColor:XZRGB(0x018eb0) forState:UIControlStateNormal];
    }
}

#pragma mark - Getter

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
