//
//  UITableViewCell+PDAutoCellHeight.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UITableViewCell+PDAutoCellHeight.h"
#import <objc/runtime.h>

@implementation UITableViewCell (PDAutoCellHeight)

#pragma mark - Setter Methods
- (void)setPd_cellBottomView:(UIView *)pd_cellBottomView {
    objc_setAssociatedObject(self, @selector(pd_cellBottomView), pd_cellBottomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPd_cellBottomOffset:(CGFloat)pd_cellBottomOffset {
    objc_setAssociatedObject(self, @selector(pd_cellBottomOffset), @(pd_cellBottomOffset), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Getter Methods
- (UIView *)pd_cellBottomView {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGFloat)pd_cellBottomOffset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end
