//
//  WebsiteViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebsiteViewController.h"

@interface WebsiteViewController ()

@end

@implementation WebsiteViewController
@synthesize url = _url;
@synthesize webView = _webView;
@synthesize loadingIcon = _loadingIcon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.loadingIcon startAnimating];

	// Do any additional setup after loading the view.
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:requestObj];
    
    [self.loadingIcon setHidesWhenStopped:YES];
    [self.loadingIcon stopAnimating];

}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setLoadingIcon:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
