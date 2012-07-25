//
//  WebsiteViewController.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteViewController : UIViewController
@property (nonatomic, weak) NSURL *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIcon;
@end
