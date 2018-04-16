//
//  UITableViewCell+PDCellAutoHeight.h
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (PDCellAutoHeight)

@property (nonatomic, strong) NSArray<UIView *> *pd_bottomViews; ///< Bottom views on the cell.
@property (nonatomic, strong) UIView *pd_bottomView; ///< Bottom view on the cell.
@property (nonatomic, assign) CGFloat pd_bottomOffset; ///< Bottom edge of the view at the bottom of the cell.
@property (nonatomic, assign, readonly) CGFloat pd_cellHeight; ///< Fetch cell height according to pd_bottomView and pd_bottomOffset.
@property (nonatomic, assign) BOOL pd_enforceFrameLayout; ///< Default is NO.

@end

NS_ASSUME_NONNULL_END
