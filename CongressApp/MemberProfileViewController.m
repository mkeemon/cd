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
#import "WebsiteViewController.h"


@interface MemberProfileViewController ()
@property (nonatomic, strong) NSMutableArray *contactCategories;
@end

@implementation MemberProfileViewController
@synthesize name = _name;
@synthesize dob = _dob;
@synthesize party = _party;
@synthesize profileImage;
@synthesize memberID = _memberID;
@synthesize contactCategories = _contactCategories;

@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize memberInfo = _memberInfo;
@synthesize contactTableView = _contactTableView;



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
        [self setMemberID:mem_id];
        
    }
    return self;
}

- (IBAction)callNumber:(UIButton *)sender {
    
    NSString *formattedNumber = [NSString stringWithFormat:@"%@", sender.currentTitle];
    PhoneNumberFormatter *p = [[PhoneNumberFormatter alloc]init];
    NSString *number = [p strip:formattedNumber];
    //NSLog(@"%@", number);
    
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
    //NSLog(@"%@", self.memberID);
    self.contactCategories = [[NSMutableArray alloc]initWithObjects: @"phone", @"url",@"email_link",@"twitter_id",@"youtube_id", nil ];

    [self getMemberInfo];
}

- (void) getMemberInfo{
    NSString * strURL = [NSString stringWithFormat:@"http://23.23.139.37/get_member_by_id?id=%@", self.memberID];
    //NSLog(@"%@", strURL);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        self.memberInfo = [JSON valueForKey:@"data"];
        //NSLog(@"%@", self.memberInfo);
        NSMutableArray *nullCategories = [[NSMutableArray alloc]init];
        
        for(NSString *category in self.contactCategories)
        {
            NSString *info = [self.memberInfo valueForKey:category];
            //NSLog(@"%@ %@", category, info);

            if([info isEqualToString:@""] || [info isEqualToString:@"0"])
            {
                //NSLog([NSString stringWithFormat:@"%@", self.memberInfo]);
                [nullCategories addObject:category];
            }
        }
        for(NSString *category in nullCategories)
        {
            [self.contactCategories removeObject:category];
        }
        self.contactTableView.separatorColor = [UIColor clearColor];
        [self.activityIndicatorView stopAnimating];
        [self.contactTableView setHidden:NO];
        [self.contactTableView reloadData]; 
        
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
    [self.dob setText:[NSString stringWithFormat:@"DOB: %@", dob]];
    
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
    else //if([party isEqualToString:@"I"])
    {
        partyFull = @"Independent";
    }
    [self.party setText:[NSString stringWithFormat:@"Party: %@", partyFull]];
    
    //Profile Image
    NSString *img = [NSString stringWithFormat:[self.memberInfo valueForKey:@"img_url_large"]];
    
    NSURL *url = [NSURL URLWithString:img];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    
    self.profileImage.image = [UIImage imageWithData:imgData];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.contactCategories && self.contactCategories.count)
    {
        return self.contactCategories.count; 
    }
    else
    {
        return 0;   
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    
    //NSString *cellValue = [array objectAtIndex:indexPath.row];

    cell.textLabel.text = [self formatCellTextAtIndex:indexPath.row];
    
    
    
    return cell;
}


-(NSString *) formatCellTextAtIndex: (int) index{
    NSString *category = [self.contactCategories objectAtIndex:index];
    if([category isEqualToString:@"phone"])
    {
        NSString *number = [self.memberInfo valueForKey:@"phone"];
        PhoneNumberFormatter *p = [[PhoneNumberFormatter alloc]init];
        NSString *formattedNumber = [p format:number withLocale:@"us"];
        
        return [NSString stringWithFormat:@"Call Office: %@", formattedNumber];
    }
    else if([category isEqualToString:@"url"])
    {
        return [NSString stringWithFormat:@"Visit Web Page"];
    }
    else if([category isEqualToString:@"youtube_id"])
    {
        return [NSString stringWithFormat:@"Visit YouTube Page"];

    }
    else if([category isEqualToString:@"twitter_id"])
    {
        return [NSString stringWithFormat:@"View Twitter Profile"];

    }
    else if([category isEqualToString:@"email_link"])
    {
        return [NSString stringWithFormat:@"Email"];

    }
    else 
    {
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *category = [self.contactCategories objectAtIndex:indexPath.row];
    NSString *value = [self.memberInfo valueForKey:category];
    if([category isEqualToString:@"phone"])
    {
        NSURL *url = [NSURL URLWithString:value];
        [[UIApplication sharedApplication] openURL:url];
    }
    else{
        NSURL *url;
        if([category isEqualToString:@"url"] ||[category isEqualToString:@"email_link"])
        {
            url = [NSURL URLWithString:value];

        }
        else if([category isEqualToString:@"youtube_id"])
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/user/%@",value]];

        }
        else if([category isEqualToString:@"twitter_id"])
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@",value]];
        }
        
        [self segueToWebView:url];
    }
    
}

- (void) segueToWebView:(NSURL *) url{
    [self performSegueWithIdentifier:@"WebView" sender:url];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"WebView"]){
        [segue.destinationViewController setUrl:sender];
    }
    
}

- (void)viewDidUnload
{
    [self setContactTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
