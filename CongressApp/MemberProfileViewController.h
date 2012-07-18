//
//  MemberProfileViewController.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberProfileViewController : UIViewController

@property (weak, nonatomic) NSString * member_id;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *party;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumber;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

- (IBAction)callNumber:(UIButton *) sender;
- (IBAction)EmailAddress;

- (id)initWithMemberID:(NSString*)mem_id;
@end
