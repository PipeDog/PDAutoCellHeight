//
//  UITableView+PDAutoCellHeight.h
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const PDCacheInfoUniqueIDKey; // Cell id.
FOUNDATION_EXTERN NSString *const PDCacheInfoIsDynamicKey; // Whether the height will change.

typedef void (^PDAutoCellHeightConfigBlock)(__kindof UITableViewCell *sourceCell);
typedef NSDictionary *(^PDAutoCellHeightCacheInfoBlock)(void);

@interface UITableView (PDAutoCellHeight)

// Recompute the cell height each time.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath config:(PDAutoCellHeightConfigBlock)config;

// The cell height is calculated according to the uniqueID cache.
- (CGFloat)pd_heightForRowAtIndexPath:(NSIndexPath *)indexPath config:(PDAutoCellHeightConfigBlock)config cacheInfo:(PDAutoCellHeightCacheInfoBlock)cacheInfo;

@end
