//
//  LoadingScreenViewController.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingScreenViewController : UIViewController
@property (nonatomic, strong) NSArray *senateMembersByState;
@property NSArray *houseMembersByState;
@property (nonatomic, strong) NSMutableDictionary *membersPictures;
//@property (nonatomic, strong) NSArray *states;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@end
