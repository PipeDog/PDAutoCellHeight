//
//  UITableViewCell+PDAutoCellHeight.h
//  PDAutoCellHeight
//
//  Created by liang on 2018/2/22.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (PDAutoCellHeight)

@property (nonatomic, strong) UIView *pd_cellBottomView; // Bottom view on the cell.
@property (nonatomic, assign) CGFloat pd_cellBottomOffset; // Bottom edge of the view at the bottom of the cell.

@end

NS_ASSUME_NONNULL_END
