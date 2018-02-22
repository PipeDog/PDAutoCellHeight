//
//  UITableView+PDAutoCellHeight.m
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "UITableView+PDAutoCellHeight.h"
#import "UITableViewCell+PDAutoCellHeight.h"
#import <objc/runtime.h>

NSString *const PDCacheInfoUniqueIDKey = @"uniqueID";
NSString *const PDCacheInfoIsDynamicKey = @"isDynamic";

@interface UITableView ()

@property (nonatomic, strong, readonly) NSMutableDictionary *cacheInfoDict;

@end

@implementation UITableView (PDAutoCellHeight)

- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath config:(PDAutoCellHeightConfigBlock)config {
    return [self pd_heightForRowAtIndexPath:indexPath config:config cacheInfo:^NSDictionary *{
        return @{PDCacheInfoUniqueIDKey: @"",
                 PDCacheInfoIsDynamicKey: @(NO)};
    }];
}

- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath config:(PDAutoCellHeightConfigBlock)config cacheInfo:(PDAutoCellHeightCacheInfoBlock)cacheInfo {
    NSString *uniqueId = [cacheInfo() objectForKey:PDCacheInfoUniqueIDKey];
    BOOL isDynamic = [[cacheInfo() objectForKey:PDCacheInfoIsDynamicKey] boolValue];
    
    if (!(uniqueId.length > 0)) {
        CGSize size = CGSizeMake(indexPath.section, indexPath.row);
        uniqueId = NSStringFromCGSize(size);
    }
    BOOL alreadyCacheInfo = [[self.cacheInfoDict allKeys] containsObject:uniqueId];
    if (!isDynamic && alreadyCacheInfo) {
        return [self.cacheInfoDict[uniqueId] floatValue];
    } else {
        CGFloat cellHeight = [self privateHeightForRowAtIndexPath:indexPath config:config];
        self.cacheInfoDict[uniqueId] = [NSNumber numberWithDouble:cellHeight];
        return cellHeight;
    }
}

#pragma mark - Private Methods
- (CGFloat)privateHeightForRowAtIndexPath:(NSIndexPath *)indexPath config:(PDAutoCellHeightConfigBlock)config {
    UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
    if (!self.dataSource || !cell/* || !cell.pd_cellBottomView*/) {
        return 0.f;
    }
    if (config) {
        config(cell);
    }
    [cell layoutIfNeeded];
    CGFloat cellHeight = 0.f;
    if (cell.pd_cellBottomView) {
        cellHeight = CGRectGetMaxY(cell.pd_cellBottomView.frame);
    } else {
        for (UIView *subview in cell.subviews) {
            cellHeight = MAX(CGRectGetMaxY(subview.frame), cellHeight);
        }
    }
    cellHeight += cell.pd_cellBottomOffset;
    return cellHeight;
}

#pragma mark - Getter Methods
- (NSMutableDictionary *)cacheInfoDict {
    NSMutableDictionary *cacheInfoDict = objc_getAssociatedObject(self, _cmd);
    if (!cacheInfoDict) {
        cacheInfoDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, cacheInfoDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cacheInfoDict;
}

@end
