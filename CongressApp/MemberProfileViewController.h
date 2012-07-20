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
    NSArray *_memberInfo;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;



@property (weak, nonatomic) NSString *memberID;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *party;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;


@property (retain, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (retain, nonatomic) NSArray *memberInfo;
@property (retain, nonatomic) UITableView *contactTableView;


- (id)initWithMemberID:(NSString*)mem_id;
@end
