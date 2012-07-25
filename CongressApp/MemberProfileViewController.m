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
@synthesize party = _party;
@synthesize profileImage;
@synthesize age = _age;
@synthesize state = _state;
@synthesize chamber = _chamber;
@synthesize navBar = _navBar;
@synthesize member = __member;
@synthesize contactCategories = _contactCategories;

@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize contactTableView = _contactTableView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (id)initWithMemberID:(NSDictionary*)member
{
    self = [super init];
    if (self) 
    {
        // Custom initialization
        [self setMember:member];
        
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
    
    NSURL *emailURL = [NSURL URLWithString:[self.member valueForKey:@"email"]];
    [[UIApplication sharedApplication] openURL:emailURL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //NSLog(@"%@", self.memberID);
    self.contactCategories = [[NSMutableArray alloc]initWithObjects: @"phone", @"url",@"email_link",@"twitter_id",@"youtube_id", nil ];
    self.contactTableView.separatorColor = [UIColor clearColor];
    [self getMember];
    self.contactTableView.scrollEnabled = NO;
}

- (void) getMember{
    
    NSMutableArray *nullCategories = [[NSMutableArray alloc]init];

    for(NSString *category in self.contactCategories)
    {
        NSString *info = [self.member valueForKey:category];
        //NSLog(@"%@ %@", category, info);
        
        if([info isEqualToString:@""] || [info isEqualToString:@"0"])
        {
            //NSLog([NSString stringWithFormat:@"%@", self.member]);
            [nullCategories addObject:category];
        }
    }
    for(NSString *category in nullCategories)
    {
        [self.contactCategories removeObject:category];
    }
    [self.activityIndicatorView stopAnimating];
    [self.contactTableView setHidden:NO];
    [self.contactTableView reloadData]; 
    
    [self setViewValues];
    
    /*
    NSString * strURL = [NSString stringWithFormat:@"http://23.23.139.37/get_member_by_id?id=%@", self.memberID];
    //NSLog(@"%@", strURL);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        self.member = [JSON valueForKey:@"data"];
        //NSLog(@"%@", self.member);
        NSMutableArray *nullCategories = [[NSMutableArray alloc]init];
        
        for(NSString *category in self.contactCategories)
        {
            NSString *info = [self.member valueForKey:category];
            //NSLog(@"%@ %@", category, info);

            if([info isEqualToString:@""] || [info isEqualToString:@"0"])
            {
                //NSLog([NSString stringWithFormat:@"%@", self.member]);
                [nullCategories addObject:category];
            }
        }
        for(NSString *category in nullCategories)
        {
            [self.contactCategories removeObject:category];
        }
        [self.activityIndicatorView stopAnimating];
        [self.contactTableView setHidden:NO];
        [self.contactTableView reloadData]; 
        
        [self setViewValues];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
     */
}

- (void) setViewValues{
    
    //name -- ADD MIDDLE NAME IN THERE
    NSString *fn = [NSString stringWithFormat:@"%@", [self.member valueForKey:@"first_name"]];
    NSString *mn = [NSString stringWithFormat:@"%@", [self.member valueForKey:@"middle_name"]];
    NSString *ln = [NSString stringWithFormat:@"%@", [self.member valueForKey:@"last_name"]];
    [self.name setText:[NSString stringWithFormat:@"%@, %@ %@", ln, fn, mn]];
    
    [self.navBar setTitle:[NSString stringWithFormat:@"%@, %@ %@", ln, fn, mn]];


    //age
    NSString *age = [NSString stringWithFormat:@"%@", [self.member valueForKey:@"age"]];
    [self.age setText:[NSString stringWithFormat:@"Age: %@", age]];
    
    //party
    NSString *party = [NSString stringWithFormat:@"%@", [self.member valueForKey:@"current_party"]];
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
    
    //chamber
    NSString *chamberStr = @"";
    if([[self.member valueForKey:@"chamber"] isEqualToString:@"house"])
    {
        chamberStr = @"House of Representatives";
    }
    else 
    {
        chamberStr = @"Senate";
    }
    
    [self.chamber setText:[NSString stringWithFormat:@"Chamber: %@", chamberStr]];
    [self.chamber sizeToFit];

    //state
    [self.state setText:[NSString stringWithFormat:@"State: %@", [self.member valueForKey:@"state"]]];
    
    //Profile Image
    NSString *img = [NSString stringWithFormat:[self.member valueForKey:@"img_url_large"]];
    
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
        NSString *number = [self.member valueForKey:@"phone"];
        PhoneNumberFormatter *p = [[PhoneNumberFormatter alloc]init];
        NSString *formattedNumber = [p format:number withLocale:@"us"];
        
        return [NSString stringWithFormat:@"Office Phone: %@", formattedNumber];
    }
    else if([category isEqualToString:@"url"])
    {
        return [NSString stringWithFormat:@"Web Page"];
    }
    else if([category isEqualToString:@"youtube_id"])
    {
        return [NSString stringWithFormat:@"YouTube Page"];

    }
    else if([category isEqualToString:@"twitter_id"])
    {
        return [NSString stringWithFormat:@"Twitter Profile"];

    }
    else if([category isEqualToString:@"email_link"])
    {
        return [NSString stringWithFormat:@"Contact Form"];

    }
    else 
    {
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *category = [self.contactCategories objectAtIndex:indexPath.row];
    NSString *value = [self.member valueForKey:category];
    if([category isEqualToString:@"phone"])
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", value]];
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
    [self setAge:nil];
    [self setAge:nil];
    [self setAge:nil];
    [self setState:nil];
    [self setChamber:nil];
    [self setNavBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
