//
//  CongressDirectoryViewController.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CongressDirectoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *response;
@property (weak, nonatomic) NSString *category;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end
