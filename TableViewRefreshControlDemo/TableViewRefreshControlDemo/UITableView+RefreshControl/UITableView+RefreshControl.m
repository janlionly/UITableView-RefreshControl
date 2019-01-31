//
//  UITableView+RefreshControl.m
//  JLUIKit
//
//  Created by laizhijian on 2019/1/16.
//  Copyright © 2019 janlionly. All rights reserved.
//

#import "UITableView+RefreshControl.h"
#import <objc/runtime.h>

#define kRefreshControlTag      3168134

@implementation UITableView (RefreshControl)

static char refreshingBlockKey;
static char endBlockKey;

- (void (^)(void))refreshingBlock {
    return (id)objc_getAssociatedObject(self, &refreshingBlockKey);
}

- (void)setRefreshingBlock:(void (^)(void))refreshBlock {
    objc_setAssociatedObject(self, &refreshingBlockKey, (id)refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))endBlock {
    return (id)objc_getAssociatedObject(self, &endBlockKey);
}

- (void)setEndBlock:(void (^)(void))endBlock {
    objc_setAssociatedObject(self, &endBlockKey, (id)endBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setupRefreshControlWithTitle:(nullable NSString *)title
                          titleColor:(nonnull UIColor *)titleColor
                      indicatorColor:(nonnull UIColor *)indicatorColor
                     refreshingBlock:(nullable void (^)(void))refreshingBlock
                            endBlock:(nullable void (^)(void))endBlock {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:indicatorColor];
    [refreshControl setBackgroundColor:[UIColor clearColor]];
    if (title.length) {
        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: titleColor}];
    }
    refreshControl.tag = kRefreshControlTag;
    [refreshControl addTarget:self action:@selector(handleRefreshing) forControlEvents:UIControlEventValueChanged];
    [self addSubview:refreshControl];
    self.refreshingBlock = refreshingBlock;
    self.endBlock = endBlock;
}

- (void)handleRefreshing {
    if (self.refreshingBlock) {
        self.refreshingBlock();
    }
}

- (void)startRefreshing {
    UIRefreshControl *refreshControl = [self viewWithTag:kRefreshControlTag];
    
    if(self.contentOffset.y == 0) {
        self.contentOffset = CGPointMake(0, -refreshControl.frame.size.height);
        [refreshControl beginRefreshing];
        [self handleRefreshing];
    }
}

- (void)endRefreshing {
    UIRefreshControl *refreshControl = [self viewWithTag:kRefreshControlTag];
    [refreshControl endRefreshing];
    
    if (self.endBlock) {
        self.endBlock();
    }
}

@end
