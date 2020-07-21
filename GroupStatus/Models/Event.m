//
//  Event.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Event.h"
@interface Event()
@property (readwrite) NSString *eventName;
@property (readwrite) NSString *eventDescription;
@property (readwrite) NSString *timelineId;

@end

@implementation Event
@dynamic timelineId;
@dynamic time;
@dynamic eventName;
@dynamic eventDescription;
@dynamic membersAttending;

+ (nonnull NSString *)parseClassName {
    return @"Event";
}
-(instancetype)initWithEventName:(NSString *)name withDescription:(NSString *)description withTime:(NSDate *)time
{
    if(self = [super init])
    {
    self.eventName =name;
    self.eventDescription =description;
    self.time = time;
   
    }
     return self;
}

+ (void)saveEventOnServer:(Event *)event withCompletion:(PFBooleanResultBlock)completion
{
    [event saveInBackgroundWithBlock:completion];
}
@end
