//
//  UITableView+PDCellAutoHeight.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UITableView+PDCellAutoHeight.h"
#import "UITableViewCell+PDCellAutoHeight.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong, readonly) NSMutableDictionary *cellHeights;

@end

@implementation UITableView (PDCellAutoHeight)

- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                     configureHandler:(void (^)(__kindof UITableViewCell * _Nonnull))handler {
    return [self pd_heightForRowAtIndexPath:indexPath reuseIdentifier:@"" configureHandler:handler];
}

- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                      reuseIdentifier:(NSString *)reuseIdentifier
                     configureHandler:(void (^)(__kindof UITableViewCell * _Nonnull))handler {
    if (!reuseIdentifier.length) {
        return [self heightForRowAtIndexPath:indexPath configureHandler:handler];
    }
    
    CGFloat cellHeight = [self.cellHeights[reuseIdentifier] floatValue];
    if (cellHeight > 0.f) return cellHeight;
    
    cellHeight = [self heightForRowAtIndexPath:indexPath configureHandler:handler];
    self.cellHeights[reuseIdentifier] = @(cellHeight);
    return cellHeight;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
                  configureHandler:(void (^)(__kindof UITableViewCell *cell))handler {
    if (!handler) {
        return 0.f;
    }
    
    UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return 0.f;
    }
    
    handler(cell);
    return cell.pd_cellHeight;
}

#pragma mark - Getter Methods
- (NSMutableDictionary *)cellHeights {
    NSMutableDictionary *cellHeights = objc_getAssociatedObject(self, _cmd);
    if (!cellHeights) {
        cellHeights = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, cellHeights, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cellHeights;
}

@end
