//
//  Group.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Group.h"

@implementation Group
@dynamic groupId;
@dynamic groupName;
@dynamic groupDescription;
@dynamic members;
@dynamic memberCount;

+ (nonnull NSString *)parseClassName {
    return @"Group";
}

+ (void) createGroup: ( NSString * _Nullable )name withDescription: (NSString * _Nullable)description withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Group *newGroup = [Group new];
    
       newGroup.groupName =name;
       newGroup.groupDescription =description;
       newGroup.memberCount = @(0);
       newGroup.members = [NSMutableArray new];
    
    [newGroup saveInBackgroundWithBlock: completion];
}
@end
