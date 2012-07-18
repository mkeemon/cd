//
//  Member.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Member : NSObject
@property (nonatomic, weak) NSString *firstName;
@property (nonatomic, weak) NSString *middleName;
@property (nonatomic, weak) NSString *lastName;
@property (nonatomic, weak) NSString *party;
@property (nonatomic, weak) NSString *url;
@property (nonatomic, weak) NSString *memberID;

@end
