//
//  ICDetailHeadView.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/21.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICDetailHeadView.h"
#import "ICDetailButton.h"


#define ICHeadMaxCols 4

@interface ICDetailHeadView ()

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIButton *topHeadBtn;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *changeNameBtn;

@end

@implementation ICDetailHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


#pragma mark - Event

- (void)deleteBtnClicked
{
    if ([self.headDelegate respondsToSelector:@selector(deleteBtnClicked)]) {
        [self.headDelegate deleteBtnClicked];
    }
}

- (void)addBtnClicked
{
    if ([self.headDelegate respondsToSelector:@selector(addBtnClicked)]) {
        [self.headDelegate addBtnClicked];
    }
}

- (void)headBtnClicked:(ICDetailButton *)headBtn
{
    if ([self.headDelegate respondsToSelector:@selector(headBtnClicked:)]) {
        [self.headDelegate headBtnClicked:headBtn.tag];
    }
}

- (void)changeName
{
    if ([self.headDelegate respondsToSelector:@selector(changeGroupName)]) {
        [self.headDelegate changeGroupName];
    }
}

- (void)changeHeadImg
{
    if ([self.headDelegate respondsToSelector:@selector(changeGroupHeadImg)]) {
        [self.headDelegate changeGroupHeadImg];
    }
}

#pragma mark - private

- (void)setUsers:(NSArray *)users
{
    _users    = users;
    
    NSUInteger count  = users.count;
    for (int i = 0; i < count; i ++) {
        XZUser *user            = _users[i];
        ICDetailButton *headBtn = [[ICDetailButton alloc] init];
        [headBtn setImage:[UIImage imageNamed:@"mayun.jpg"] forState:UIControlStateNormal];
        [headBtn setTitle:user.eName forState:UIControlStateNormal];
         headBtn.tag             = i;
        [self addSubview:headBtn];
        [headBtn addTarget:self action:@selector(headBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:self.addBtn];
    
    if (self.isMaster) {
        [self addSubview:self.deleteBtn];
        [self.topView addSubview:self.changeNameBtn];
    }
    [self.topHeadBtn addTarget:self action:@selector(changeHeadImg) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setGroup:(XZGroup *)group
{
    _group = group;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat topImageH = ICTopImageH;
    if (![_group.gType isEqualToString:@"2"]) {
        topImageH = 0;
    }
    self.topView.frame = CGRectMake(0, -topImageH, self.width, topImageH);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left);
        make.right.equalTo(self.topView.mas_right);
        make.bottom.equalTo(self.topView.mas_bottom).offset(-5);
        make.height.mas_equalTo(40);
    }];
    [self.topHeadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView.mas_centerX);
        make.bottom.equalTo(self.nameLabel.mas_top).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
//    self.topHeadBtn.frame = CGRectMake(0, 15, 80, 80);
//    self.topHeadBtn.centerX  = App_Frame_Width*0.5;
    
//    _nameLabel.frame = CGRectMake(0, _topHeadBtn.bottom+18, 60, 40);
//    [_nameLabel sizeToFit];
//    _nameLabel.centerX = _topHeadBtn.centerX;
    _changeNameBtn.frame = CGRectMake(_nameLabel.right+2, _nameLabel.top, 40, 40);
    _changeNameBtn.centerY = _nameLabel.centerY;
    
    CGFloat inset            = 14;
    NSUInteger count = self.users.count;
    CGFloat btnW     = (self.width - 2*inset)/ICHeadMaxCols;
    CGFloat btnH     = btnW;
    for (int i = 0; i < count; i ++) {
        ICDetailButton *btn = self.subviews[i];
        btn.width           = btnW;
        btn.height          = btnH;
        btn.x               = inset + (i % ICHeadMaxCols)*btnW;
//        btn.y               = (i / ICHeadMaxCols)*btnH + topImageH;
        btn.y               = (i / ICHeadMaxCols)*btnH;
    }
    self.addBtn.width     = btnW;
    self.addBtn.height    = btnH;
    self.addBtn.x         = inset + (count%ICHeadMaxCols)*btnW;
//    self.addBtn.y         = (count/ICHeadMaxCols)*btnH + topImageH;
    self.addBtn.y         = (count/ICHeadMaxCols)*btnH;
    
    if (self.isMaster && _users.count > 2) { // 3个人以上
        self.deleteBtn.width     = btnW;
        self.deleteBtn.height    = btnH;
        self.deleteBtn.x         = inset + ((count+1)%ICHeadMaxCols)*btnW;
//        self.deleteBtn.y         = ((count+1)/ICHeadMaxCols)*btnH + topImageH;
        self.deleteBtn.y         = ((count+1)/ICHeadMaxCols)*btnH;
    }
}


- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"addbtn"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _addBtn;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = XZRGB(0x027996);
        [_topView addSubview:self.topHeadBtn];
        [_topView addSubview:self.nameLabel];
    }
    return _topView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIButton *)topHeadBtn
{
    if (!_topHeadBtn) {
        _topHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topHeadBtn.layer.masksToBounds = YES;
        _topHeadBtn.layer.cornerRadius  = 40;
    }
    return _topHeadBtn;
}

- (UIButton *)changeNameBtn
{
    if (!_changeNameBtn) {
        _changeNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeNameBtn setImage:[UIImage imageNamed:@"xiugaiqunming"] forState:UIControlStateNormal];
        [_changeNameBtn addTarget:self action:@selector(changeName) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeNameBtn;
}


@end
