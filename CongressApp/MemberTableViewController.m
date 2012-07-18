//
//  HouseMemberTableViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MemberTableViewController.h"
#import "AFNetworking.h"
#import "State.h"
#import "MemberProfileViewController.h"
#import "Member.h"

@interface MemberTableViewController ()
@property (nonatomic, strong) NSMutableArray *stateArray;
@property (nonatomic, strong) NSMutableArray *statesMembers;
@property (nonatomic, strong) NSMutableArray *fullStateNames;
@end


@implementation MemberTableViewController
@synthesize tableView = _tableView; 
@synthesize activityIndicatorView = _activityIndicatorView; 
@synthesize members = _members;

@synthesize chamber = _chamber;
@synthesize navBar = _navBar;

@synthesize stateArray = _stateArray;
@synthesize statesMembers = _statesMembers;
@synthesize fullStateNames = _fullStateNames;


- (void) getMembersByState{
    
    
    
    NSMutableString *uri = [NSMutableString stringWithString: @"http://23.23.139.37/members_by_state.php?chamber="];
    [uri appendString:self.chamber];
    //NSLog(@"%@", uri);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:uri]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        self.members = [JSON valueForKey:@"data"];
        for(NSString *state in self.stateArray) {
            
            NSArray *members = [self.members valueForKey:state];
            [self.statesMembers addObject:members];
        }
        
        //NSLog(@"%@", self.statesMembers);
        
        [self.activityIndicatorView stopAnimating];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setting Up Table View
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    // Initializing Data Source
    self.members = [[NSArray alloc] init];
    self.stateArray = [[NSMutableArray alloc] init];
    self.statesMembers = [[NSMutableArray alloc] init];
    self.fullStateNames = [[NSMutableArray alloc] init];

    [self initStates];
    [self getMembersByState];
    
    if([self.chamber isEqualToString:@"house"]){
        self.navBar.title = @"Members: House of Representatives";
    }
    else{
        self.navBar.title = @"Members: Senate";

    }
    
    
   
    
}



- (void) initStates{
    //self.stateArray = [[NSMutableArray alloc] initWithObjects:@"AL", nil];
    
    NSMutableArray *states = [[NSMutableArray alloc] initWithObjects:@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DE",@"FL",@"GA",@"HI",@"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN",@"MS",@"MO",@"MT",@"NE",@"NV",@"NH",@"NJ",@"NM",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",@"TN",@"TX",@"UT",@"VT",@"VA",@"WA",@"WV",@"WI",@"WY", nil];
    
    NSMutableArray *allStatesNames = [[NSMutableArray alloc ] initWithObjects:@"Alabama",@"Alaska",@"Arizona",@"Arkansas",@"California",@"Colorado",@"Connecticut",@"Delaware",@"Florida",@"Georgia",@"Hawaii",@"Idaho",@"Illinois",@"Indiana",@"Iowa",@"Kansas",@"Kentucky",@"Louisiana",@"Maine",@"Maryland",@"Massachusetts",@"Michigan",@"Minnesota",@"Mississippi",@"Missouri",@"Montana",@"Nebraska",@"Nevada",@"New Hampshire",@"New Jersey",@"New Mexico",@"New York",@"North Carolina",@"North Dakota",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania",@"Rhode Island",@"South Carolina",@"South Dakota",@"Tennessee",@"Texas",@"Utah",@"Vermont",@"Virginia",@"Washington",@"West Virginia",@"Wisconsin",@"Wyoming", nil];
    if([self.chamber isEqualToString:@"house"])
    {
        [states addObject:@"DC"];
        [allStatesNames addObject:@"Washington DC"];
        [states addObject:@"AS"];
        [allStatesNames addObject:@"American Somoa"];
        [states addObject:@"GU"];
        [allStatesNames addObject:@"Guam"];
        [states addObject:@"MP"];
        [allStatesNames addObject:@"Northen Mariana Islands"];
        [states addObject:@"PR"];
        [allStatesNames addObject:@"Puerto Rico"];
        [states addObject:@"VI"];
        [allStatesNames addObject:@"US Virgin Islands"];
       
    }
    
    self.stateArray = states;
    self.fullStateNames = allStatesNames;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.statesMembers && self.statesMembers.count)
    {
        NSArray *members= [self.statesMembers objectAtIndex:section];
        
        return [members count]; 
    }
    else
    {
        return 0;   
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.statesMembers count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.fullStateNames objectAtIndex:section];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *members = [self.statesMembers objectAtIndex:indexPath.section];
    NSDictionary *member = [members objectAtIndex:indexPath.row];
    NSString *party = [member objectForKey:@"current_party"];
    NSLog(@"%@",party);
    NSLog(@"%@",member);
    cell.textLabel.textColor = [UIColor whiteColor];

    if([party isEqualToString:@"D"])
    {
        cell.backgroundColor = [UIColor blueColor];

    }
    else if([party isEqualToString:@"R"])
    {
        cell.backgroundColor = [UIColor redColor];


    }
    else //if([party isEqualToString:@"I"])
    {
        cell.backgroundColor = [UIColor lightGrayColor];

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    
    //NSString *cellValue = [array objectAtIndex:indexPath.row];

   // NSDictionary *member = [self.members objectAtIndex:indexPa;th.row]
    NSArray *members = [self.statesMembers objectAtIndex:indexPath.section];
    NSDictionary *member = [members objectAtIndex:indexPath.row];
    NSString *f_n = [member objectForKey:@"first_name"];
    NSString *l_n = [member objectForKey:@"last_name"];
    NSString *m_n = [member objectForKey:@"middle_name"];

    
    
    
    NSString *img = [member valueForKey:@"img_url_small"];
    NSURL *url = [NSURL URLWithString:img];
    
    NSData *imgData = [NSData dataWithContentsOfURL:url];
  
    cell.imageView.image = [self imageWithImage: [UIImage imageWithData:imgData] scaledToSize:CGSizeMake(150,200)];
   // cell.imageView.image = [UIImage imageWithData:imgData];

    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@ %@", l_n, f_n, m_n];

    
    
    return cell;
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSArray *members = [self.statesMembers objectAtIndex:indexPath.section];
    NSDictionary *member = [members objectAtIndex:indexPath.row];
    NSString *memberID = [member valueForKey:@"id"];
    [self segueToMemberProfile: memberID];
}


- (void) segueToMemberProfile:(NSString *) memberID{
    [self performSegueWithIdentifier:@"MemberProfile" sender:memberID];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MemberProfile"]){
        [segue.destinationViewController setMember_id:sender];
    }
    
}




- (void)viewDidUnload
{
    [self setNavBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
