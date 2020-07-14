//
//  Event.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Event.h"

@implementation Event
@dynamic eventID;
@dynamic timelineId;
@dynamic time;
@dynamic eventName;
@dynamic eventDescription;
@dynamic membersAttending;

+ (nonnull NSString *)parseClassName {
    return @"Event";
}
+(void) createEvent:(NSString * _Nullable)name withDescription:(NSString * _Nullable)description Attending:(NSNumber * _Nullable)member withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Event *newEvent = [Event new];
    
       newEvent.eventName =name;
       newEvent.eventDescription =description;
       newEvent.membersAttending = member;
       
    
    [newEvent saveInBackgroundWithBlock: completion];
}
@end
