//
//  CategoryViewController.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"
#import "CongressDirectoryViewController.h"

@interface CategoryViewController ()
@property (nonatomic, weak) NSString *category;
@end

@implementation CategoryViewController
@synthesize category = _category;
- (void) segueToChamberList:(NSString *) category{
    self.category = category;
    [self performSegueWithIdentifier:@"ChamberList" sender:self];
    
}
- (IBAction)members {
    [self segueToChamberList:@"members"];
}

- (IBAction)committees {
    [self segueToChamberList:@"committees"];
}

- (IBAction)bills {
    [self segueToChamberList:@"bills"];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ChamberList"]){
        [segue.destinationViewController setCategory:self.category]; // set category in congressdirectoryviewcontroller
    }
}


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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
