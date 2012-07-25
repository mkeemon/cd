//
//  MemberData.m
//  CongressApp
//
//  Created by Enea Causen | unlimapps@yahoo.com on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MemberData.h"

@implementation MemberData

@synthesize senateMemberData = _senateMemberData;
@synthesize houseMemberData = _houseMemberData;


+ (id)sharedInformation {
    static MemberData *sharedInformation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInformation = [[self alloc] init];
    });
    return sharedInformation;
}


- (id)initChamber: (NSString *) chamber WithData: (id) memberData {
    if (self = [super init]) {
        if([chamber isEqualToString:@"house"])
        {
            self.houseMemberData = memberData;
        }
        else //if([chamber isEqualToString:@"senate"])
        {
            self.senateMemberData = memberData;
            //NSLog(@"%@", memberData);
        }
        //senateMemberData = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

-(id) returnMemberDataForChamber:(NSString *) chamber{
    if([chamber isEqualToString:@"house"])
    {
        return self.houseMemberData;
    }
    else //if([chamber isEqualToString:@"senate"])
    {
        return self.senateMemberData;
    }
}

@end
