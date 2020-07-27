//
//  Timeline.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Timeline.h"
#import "Event.h"
@interface Timeline()
@property (readwrite) NSString *groupID;
@end
@implementation Timeline

@dynamic events;
@dynamic groupID;
@dynamic eventCount;
@dynamic currentDate;

+ (nonnull NSString *)parseClassName {
    return @"Timeline";
}
+ (void)saveTimelineOnServer:(Timeline *)timeline withCompletion:(PFBooleanResultBlock)completion
{
    [timeline saveInBackgroundWithBlock:completion];
}
-(instancetype)initWithGroupID:(NSString *)groupId
{
    if(self = [super init])
    {
        self.groupID = groupId;
        self.eventCount = @(0);
        self.events = [NSMutableArray new];
    }
    return self;
}
-(void)addEvent:(Event *)event 
{
    [self addObject:[event objectId] forKey:@"events"];
    int value = [self.eventCount intValue];
    self.eventCount = [NSNumber numberWithInt:value + 1];
    [self saveInBackground];
    NSLog(@"Event Created!!!!");
}
@end
