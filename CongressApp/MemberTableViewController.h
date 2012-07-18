//
//  HouseMemberTableViewController.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    UIActivityIndicatorView *_activityIndicatorView;
    NSArray *_members;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, retain) NSArray *members;
@property (nonatomic, weak) NSString *chamber;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;


@end