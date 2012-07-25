//
//  LoadingScreenViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingScreenViewController.h"
#import "CongressDirectoryViewController.h"
#import "AFNetworking.h"
#import "MemberData.h"


@interface LoadingScreenViewController ()
@property (nonatomic, weak) MemberData *data;
@end

@implementation LoadingScreenViewController
@synthesize loadingView = _loadingView;
@synthesize senateMembersByState = _senateMembersByState;
@synthesize houseMembersByState = _houseMembersByState;
@synthesize data = _data;
@synthesize membersPictures = _membersPictures;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.loadingView startAnimating];
	// Do any additional setup after loading the view
    self.data = [MemberData sharedInformation];
    
    [self getAllMembers:@"senate" AndSegue:NO];
    [self getAllMembers:@"house" AndSegue:TRUE];
    //[self performSegueWithIdentifier:@"SelectionScreen" sender:self];
    

}

- (void) segueToSelectionScreen{
    [self performSegueWithIdentifier:@"SelectionScreen" sender:self];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SelectionScreen"]){
        [self.loadingView stopAnimating];

        //[segue.destinationViewController navigationBar].hidden = YES;

    }
    
}

- (void) getAllPictures: (NSString *) chamber{
    NSArray *membersByState = [chamber isEqualToString:@"house"] ? self.houseMembersByState : self.senateMembersByState;
    for(NSString *state in membersByState)
    {
        NSArray *members = [membersByState valueForKey:state];
        for(NSArray *member in members)
        {
            NSLog(@"%@",member);
            NSString *img = [member valueForKey:@"img_url_small"];
            NSURL *url = [NSURL URLWithString:img];
            NSData *imgData = [NSData dataWithContentsOfURL:url];
            [self.membersPictures setValue:imgData forKey:[member valueForKey:@"id"]];
                           
            
        }
       


    }
    
    NSLog(@"%@", self.membersPictures);
    
    
    //[self performSegueWithIdentifier:@"SelectionScreen" sender:self];

    
}

- (void) getAllMembers: (NSString *) chamber AndSegue: (BOOL) finished{
    NSString * strURL = [NSString stringWithFormat:@"http://23.23.139.37/members_by_state?chamber=%@", chamber];
    //NSLog(@"%@", strURL);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {

        id memberData = [JSON valueForKey:@"data"];

        [self.data initChamber:chamber WithData:memberData];

        //[self getAllPictures: chamber];
        if(finished)
        {
            [self segueToSelectionScreen];
        }
         
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
}

- (void)viewDidUnload
{
    [self setLoadingView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
