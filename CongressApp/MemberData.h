//
//  MemberData.h
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberData : NSObject
@property (nonatomic, retain) id senateMemberData;
@property (nonatomic, retain) id houseMemberData;
+ (id)sharedInformation;
- (id)initChamber: (NSString *) chamber WithData: (NSArray *) memberData;
- (id) returnMemberDataForChamber:(NSString *) chamber;
@end
