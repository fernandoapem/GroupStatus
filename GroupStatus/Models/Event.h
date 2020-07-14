//
//  Event.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Event : PFObject <PFSubclassing>
@property (nonatomic,strong) NSString *eventID;
@property (nonatomic,strong) NSString *timelineId;
@property (nonatomic,strong) NSDate *time;
@property (nonatomic,strong) NSString *eventName;
@property (nonatomic,strong) NSString *eventDescription;
@property (nonatomic,strong) NSNumber *membersAttending;
+(void) createEvent:(NSString * _Nullable)name withDescription:(NSString * _Nullable)description Attending:(NSNumber * _Nullable)member withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end


NS_ASSUME_NONNULL_END
