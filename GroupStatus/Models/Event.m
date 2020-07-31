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
@property (readwrite) NSString *timeString;

@end

@implementation Event
@dynamic timelineId;
@dynamic timeString;
@dynamic eventName;
@dynamic eventDescription;
@dynamic membersAttending;
@dynamic isFree;
@dynamic isActivity;
@dynamic link;

+ (nonnull NSString *)parseClassName {
    return @"Event";
}

-(instancetype)initWithEventName:(NSString *)name description:(NSString *)description time:(NSDate *)time timelineId:(NSString *)timeline link:(NSString *)link
{
    if(self = [super init])
    {
        self.eventName =name;
        self.eventDescription =description;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"hh:mm a"];
        self.timeString = [dateFormat stringFromDate:time];
        self.timelineId = timeline;
        self.isFree = NO;
        self.link = link;
    }
     return self;
}
+(void) updateEvent:(Event *)event eventName:(NSString *)name
{
    event.eventName = name;
}
+(void) updateEvent:(Event *)event eventDescription:(NSString *)description
{
   event.eventDescription = description;
}
+(void) updateEvent:(Event *)event  time:(NSDate *)time
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    event.timeString = [dateFormat stringFromDate:time];
}
+(void) updateEvent:(Event *)event link:(NSString *)link
{
    event.link = link;
}


+ (void)saveEventOnServer:(Event *)event withCompletion:(PFBooleanResultBlock)completion
{
    [event saveInBackgroundWithBlock:completion];
}
@end
