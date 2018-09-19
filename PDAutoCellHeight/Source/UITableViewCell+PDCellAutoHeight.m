//
//  UITableViewCell+PDCellAutoHeight.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UITableViewCell+PDCellAutoHeight.h"
#import <objc/runtime.h>

@implementation UITableViewCell (PDCellAutoHeight)

#pragma mark - Setter Methods
- (void)setPd_bottomViews:(NSArray<UIView *> *)pd_bottomViews {
    objc_setAssociatedObject(self, @selector(pd_bottomViews), pd_bottomViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPd_bottomView:(UIView *)pd_bottomView {
    objc_setAssociatedObject(self, @selector(pd_bottomView), pd_bottomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPd_bottomOffset:(CGFloat)pd_bottomOffset {
    objc_setAssociatedObject(self, @selector(pd_bottomOffset), @(pd_bottomOffset), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setPd_enforceFrameLayout:(BOOL)pd_enforceFrameLayout {
    objc_setAssociatedObject(self, @selector(pd_enforceFrameLayout), @(pd_enforceFrameLayout), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Getter Methods
- (NSArray<UIView *> *)pd_bottomViews {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)pd_bottomView {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGFloat)pd_bottomOffset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (BOOL)pd_enforceFrameLayout {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (CGFloat)pd_cellHeight {
    NSAssert([NSThread isMainThread] == YES, @"UI operation must be performed in the main thread.");
    
    if (self.pd_enforceFrameLayout) {
        [self layoutIfNeeded];
    }
    
    CGFloat cellHeight = 0.f;
    
    if (self.pd_bottomViews.count > 0) {
        for (UIView *subview in [self.pd_bottomViews copy]) {
            cellHeight = MAX(CGRectGetMaxY(subview.frame), cellHeight);
        }
    }
    else if (self.pd_bottomView) {
        cellHeight = CGRectGetMaxY(self.pd_bottomView.frame);
    }
    else {
        for (UIView *subview in [self.subviews copy]) {
            cellHeight = MAX(CGRectGetMaxY(subview.frame), cellHeight);
        }
        for (UIView *subview in [self.contentView.subviews copy]) {
            cellHeight = MAX(CGRectGetMaxY(subview.frame), cellHeight);
        }
    }
    cellHeight += self.pd_bottomOffset;
    return cellHeight;
}

@end
