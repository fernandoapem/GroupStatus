//
//  Timeline.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Timeline.h"

@implementation Timeline

@dynamic timelineID;
@dynamic groupID;
@dynamic eventCount;

+ (nonnull NSString *)parseClassName {
    return @"Timeline";
}
+(void)createTimelinewithGroupID:(NSString *)groupID withCompletion:(PFBooleanResultBlock)completion{
    Timeline *timeline = [Timeline new];
    timeline.groupID = groupID;
    timeline.eventCount = @(0);
    [timeline saveInBackgroundWithBlock:completion];
}
@end
