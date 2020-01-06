//
//  PDDynamicHeightCell.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDDynamicHeightCell.h"
#import "UITableViewCell+PDCellAutoHeight.h"
#import <Masonry.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

static CGFloat const kAroundMargin = 10;

@interface PDDynamicHeightCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation PDDynamicHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.pd_bottomView = self.bottomLabel;
//        self.pd_bottomViews = @[self.contentLabel];
        self.pd_bottomOffset = kAroundMargin;
        self.pd_enforceFrameLayout = YES;
        
        [self createViewHierarchy];
        [self layoutContentViews];
    }
    return self;
}

- (void)createViewHierarchy {
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.bottomLabel];
}

- (void)layoutContentViews {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kAroundMargin);
        make.left.mas_equalTo(kAroundMargin);
        
        // You should set const width for `label`
        make.width.mas_equalTo(kScreenWidth - kAroundMargin * 2);
        
        // Don't do like the follow code
        // make.width.equalTo(self.contentView.mas_width).offset(-kAroundMargin * 2);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kAroundMargin);
        make.left.and.right.equalTo(self.contentLabel);
    }];
}

#pragma mark - Public Methods
- (void)loadData:(NSString *)text {
    _contentLabel.text = text;
    [_contentLabel sizeToFit];
    
    _bottomLabel.text = text;
    [_bottomLabel sizeToFit];
}

#pragma mark - Getter Methods
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor lightGrayColor];
        _contentLabel.textColor = [UIColor darkTextColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = [UIColor lightGrayColor];
        _bottomLabel.textColor = [UIColor darkTextColor];
        _bottomLabel.font = [UIFont systemFontOfSize:13];
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _bottomLabel;
}

@end
