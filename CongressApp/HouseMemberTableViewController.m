//
//  HouseMemberTableViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HouseMemberTableViewController.h"
#import "AFNetworking.h"


@interface HouseMemberTableViewController ()
@end


@interface HouseMemberTableViewController ()

@end

@implementation HouseMemberTableViewController
@synthesize tableView = _tableView, activityIndicatorView = _activityIndicatorView, movies = _movies;
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
    self.movies = [[NSArray alloc] init];
    
    
    NSString *url = [NSMutableString stringWithString:@"http://api.nytimes.com/svc/politics/"];
    NSString *version = @"v3/";
    
    NSString *url_p2 = @"us/legislative/congress/";
    NSString *congress_number = @"112/";
    
    NSString *chamber = @"house/";
    NSString *info = @"members.json";
    NSString *apiKey = @"?api-key=a57286593f70e5fbd7a3c5f5a17f04a8:2:66232804";
    
    NSString *base_url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", url,version, url_p2, congress_number,chamber,info,apiKey];
    NSURL *uri  = [[NSURL alloc] initWithString: base_url];
    
    
    
    //NSURL *url = [[NSURL alloc] initWithString:@"http://itunes.apple.com/search?term=harry&country=us&entity=movie"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:uri];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // self.movies = [JSON objectForKey:@"results"];
        id results = [JSON valueForKey:@"results"];
        
        self.movies = [[results valueForKey:@"members"] objectAtIndex:0];//Stupid Congress API only returns 1 element in results 
        
        [self.activityIndicatorView stopAnimating];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.movies && self.movies.count) {
        return self.movies.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    NSString *f_n = [movie objectForKey:@"first_name"];
    NSString *m_n = [movie objectForKey:@"middle_name"];
    NSString *l_n = [movie objectForKey:@"last_name"];
    
    ///////////
    //FIGURE OUT HOW TO CHECK FOR NULL TYPE FOR MIDDLE NAMES
    //////////
    if(![m_n isKindOfClass:[NSNull class]])
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", f_n, m_n, l_n];

        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", f_n, l_n];

    
    //cell.detailTextLabel.text = [movie objectForKey:@"artistName"];
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
