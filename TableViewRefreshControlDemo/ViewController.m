//
//  ViewController.m
//  TableViewRefreshControlDemo
//
//  Created by laizhijian on 2019/1/31.
//  Copyright © 2019 janlionly. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+RefreshControl.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // boot 
    [self.tableView setupRefreshControlWithTitle:@"刷新中..."
                                      titleColor:[UIColor darkTextColor]
                                  indicatorColor:[UIColor lightGrayColor]
                                 refreshingBlock:^{
                                        // fetch data from server
                                        NSLog(@"starting refreshing");
                                    }
                                        endBlock:^{
                                            NSLog(@"end refresh");
                                        }];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.tableView endRefreshing];
    }];
    
    [self.tableView startRefreshing];
}


@end
