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
@property (nonatomic,copy,readonly) NSString *timelineId;
@property (nonatomic,strong,readwrite) NSDate *time;
@property (nonatomic,copy,readonly) NSString *eventName;
@property (nonatomic,copy,readonly) NSString *eventDescription;
@property (nonatomic,strong,readwrite) NSNumber *membersAttending;
-(instancetype) initWithEventName:(NSString *)name withDescription:(NSString *)description withTime:(NSDate *)time;
+(void) saveEventOnServer:(Event *)event withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end


NS_ASSUME_NONNULL_END
