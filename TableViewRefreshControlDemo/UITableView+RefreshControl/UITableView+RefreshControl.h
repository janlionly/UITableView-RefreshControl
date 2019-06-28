//
//  UITableView+RefreshControl.h
//  JLUIKit
//
//  Created by laizhijian on 2019/1/16.
//  Copyright © 2019 janlionly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (RefreshControl)

@property (nonatomic, copy, nullable) void (^refreshingBlock)(void);
@property (nonatomic, copy, nullable) void (^endBlock)(void);

- (void)setupRefreshControlWithTitle:(nullable NSString *)title
                          titleColor:(nonnull UIColor *)titleColor
                      indicatorColor:(nonnull UIColor *)indicatorColor
                     refreshingBlock:(nullable void (^)(void))refreshingBlock
                            endBlock:(nullable void (^)(void))endBlock;
- (void)startRefreshing;
- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
