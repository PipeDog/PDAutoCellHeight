//
//  UITableView+PDCellAutoHeight.h
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const PDCacheInfoUniqueIDKey; ///< Cell id.
FOUNDATION_EXTERN NSString *const PDCacheInfoIsDynamicKey; ///< Whether the height will change. If you want the height to be cached, set value to NO.

typedef void (^PDCellAutoHeightConfigBlock)(__kindof UITableViewCell *cell);
typedef NSDictionary * _Nonnull (^PDCellAutoHeightCacheInfoBlock)(void);

@interface UITableView (PDCellAutoHeight)

/// Recompute the cell height each time.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                               config:(PDCellAutoHeightConfigBlock)config;

/// The cell height is calculated according to the uniqueID cache.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath
                               config:(PDCellAutoHeightConfigBlock)config
                            cacheInfo:(PDCellAutoHeightCacheInfoBlock)cacheInfo;

@end

NS_ASSUME_NONNULL_END
