//
//  UITableView+PDCellAutoHeight.h
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (PDCellAutoHeight)

/// Recompute the cell height each time.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                     configureHandler:(void (^)(__kindof UITableViewCell *cell))handler;

/// The cell height is calculated according to the reuseIdentifier cache.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                      reuseIdentifier:(NSString *)reuseIdentifier
                     configureHandler:(void (^)(__kindof UITableViewCell *cell))handler;

@end

NS_ASSUME_NONNULL_END
