//
//  CongressDirectoryViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CongressDirectoryViewController.h"
#import "MemberTableViewController.h"
#import "MobclixAdView.h"

@interface CongressDirectoryViewController ()
@property (nonatomic, weak) NSString* chamber;
@property (nonatomic, retain) MobclixAdView *adView;
@end

@implementation CongressDirectoryViewController
@synthesize chamber = _chamber;
@synthesize category = _category;
@synthesize navBar = _navBar;

@synthesize adView = _adView;

- (void) segueToMembersList:(NSString *) chamber{
    self.chamber = chamber;
    [self performSegueWithIdentifier:@"MemberList" sender:chamber];
}

- (IBAction)house:(id)sender {
    
    [self segueToMembersList:@"house"];
}
- (IBAction)senate:(id)sender {
    [self segueToMembersList:@"senate"];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MemberList"]){
        [segue.destinationViewController setChamber:self.chamber];
    }
        
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.adView resumeAdAutoRefresh];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.adView pauseAdAutoRefresh];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navBar.hidesBackButton = YES;
    
    
    NSString *title = [self.category stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self.category substringToIndex:1] uppercaseString]];

    self.navBar.title = title;
    
	// Do any additional setup after loading the view, typically from a nib.
    //[self apiRequest];
    
    self.adView = [[MobclixAdViewiPhone_320x50 alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    [self.view addSubview:self.adView];
    
}

- (void)viewDidUnload
{
    [self setNavBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
    */
}

@end
