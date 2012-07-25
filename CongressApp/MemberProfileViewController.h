//
//  MemberProfileViewController.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberProfileViewController : UIViewController<UITableViewDataSource>{
    UITableView *_contactTableView;
    UIActivityIndicatorView *_activityIndicatorView;
    NSDictionary *_member;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (weak, nonatomic) NSDictionary *member;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *party;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *age;

@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *chamber;

@property (retain, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (retain, nonatomic) UITableView *contactTableView;


- (id)initWithMemberID:(NSString*)mem_id;
@end
