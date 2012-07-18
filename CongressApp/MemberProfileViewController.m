//
//  MemberProfileViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MemberProfileViewController.h"
#import "AFNetworking.h"
#import "PhoneNumberFormatter.h"

@interface MemberProfileViewController ()
@property (nonatomic, weak) NSArray * memberInfo;
@end

@implementation MemberProfileViewController
@synthesize memberInfo = _memberInfo;

@synthesize member_id = _member_id;
@synthesize name = _name;
@synthesize dob = _dob;
@synthesize party = _party;
@synthesize phoneNumber = _phoneNumber;
@synthesize profileImage = _profileImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (id)initWithMemberID:(NSString*)mem_id
{
    self = [super init];
    if (self) 
    {
        // Custom initialization
        [self setMember_id:mem_id];
        
    }
    return self;
}

- (IBAction)callNumber:(UIButton *)sender {
    
    NSString *formattedNumber = [NSString stringWithFormat:@"%@", sender.currentTitle];
    PhoneNumberFormatter *p = [[PhoneNumberFormatter alloc]init];
    NSString *number = [p strip:formattedNumber];
    NSLog(@"%@", number);
    
    NSURL *URL = [NSURL URLWithString:number];
    [[UIApplication sharedApplication] openURL:URL];
}

- (IBAction)EmailAddress {
    
    NSURL *emailURL = [NSURL URLWithString:[self.memberInfo valueForKey:@"email"]];
    [[UIApplication sharedApplication] openURL:emailURL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%@", self.member_id);
    [self getMemberInfo];
    CGRect frame = CGRectMake(0, 200, 500, 500); // Replacing with your dimensions
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    [self.view addSubview:view];
}

- (void) getMemberInfo{
    NSString * strURL = [NSString stringWithFormat:@"http://23.23.139.37/get_member_by_id?id=%@", self.member_id];
    NSLog(@"%@", strURL);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        self.memberInfo = [JSON valueForKey:@"data"];
        //NSLog(@"%@", self.memberInfo);
        [self setViewValues];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
}

- (void) setViewValues{
    
    //name -- ADD MIDDLE NAME IN THERE
    NSString *fn = [NSString stringWithFormat:@"%@", [self.memberInfo valueForKey:@"first_name"]];
    NSString *mn = [NSString stringWithFormat:@"%@", [self.memberInfo valueForKey:@"middle_name"]];
    NSString *ln = [NSString stringWithFormat:@"%@", [self.memberInfo valueForKey:@"last_name"]];
    [self.name setText:[NSString stringWithFormat:@"%@, %@ %@", ln, fn, mn]];
    
    //dob
    NSString *dob = [NSString stringWithFormat:@"%@", [self.memberInfo valueForKey:@"date_of_birth"]];
    [self.dob setText:[NSString stringWithFormat:@"%@", dob]];
    
    //party
    NSString *party = [NSString stringWithFormat:@"%@", [self.memberInfo valueForKey:@"current_party"]];
    NSString *partyFull = @"";
    if([party isEqualToString:@"R"])
    {
        partyFull = @"Republican";
    }
    else if([party isEqualToString:@"D"])
    {
        partyFull = @"Democrat";
    }
    else //if([party isEqualToString:@"R"])
    {
        partyFull = @"Independent";
    }
    [self.party setText:[NSString stringWithFormat:@"%@", partyFull]];
    
    //Phone Number
    NSString *number = [self.memberInfo valueForKey:@"phone"];
    PhoneNumberFormatter *p = [[PhoneNumberFormatter alloc]init];
    NSString *formattedNumber = [p format:number withLocale:@"us"];
    [self.phoneNumber setTitle:[NSString stringWithFormat:@"%@",formattedNumber] forState:UIControlStateNormal];
    
    //Profile Image
    NSString *img = [NSString stringWithFormat:[self.memberInfo valueForKey:@"img_url_large"]];
    
    NSLog(@"%@", img); //some urls are loaded incorrectly
    NSURL *url = [NSURL URLWithString:img];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    self.profileImage.image = [UIImage imageWithData:imgData];
    
}



- (void)viewDidUnload
{
    [self setName:nil];
    [self setPhoneNumber:nil];
    [self setProfileImage:nil];
    [self setDob:nil];
    [self setParty:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
