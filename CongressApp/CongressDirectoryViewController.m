//
//  CongressDirectoryViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CongressDirectoryViewController.h"
#import "AFNetworking.h"
#import "Member.h"

@interface CongressDirectoryViewController ()

@end

@implementation CongressDirectoryViewController
@synthesize response = _response;



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //if([segue.identifier isEqualToString:@"Show House Members"]{}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self apiRequest];
    
}

- (void)viewDidUnload
{
    [self setResponse:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
