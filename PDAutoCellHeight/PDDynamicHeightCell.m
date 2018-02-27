//
//  PDDynamicHeightCell.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "PDDynamicHeightCell.h"
#import "UITableViewCell+PDCellAutoHeight.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

static CGFloat const kAroundMargin = 10;

@interface PDDynamicHeightCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation PDDynamicHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // self.pd_bottomView = self.contentLabel;
        self.pd_bottomViews = @[self.contentLabel];
        self.pd_bottomOffset = kAroundMargin;
    }
    return self;
}

- (void)loadData:(NSString *)text {
    _contentLabel.text = text;
    [_contentLabel sizeToFit];
}

#pragma mark - Getter Methods
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAroundMargin, kAroundMargin, kScreenWidth - kAroundMargin * 2, 0)];
        _contentLabel.backgroundColor = [UIColor lightGrayColor];
        _contentLabel.textColor = [UIColor darkTextColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
