//
//  Timeline.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Timeline : PFObject<PFSubclassing>
@property (nonatomic,copy,readonly) NSString *groupID;
@property (nonatomic,strong) NSNumber *eventCount;
-(instancetype) initWithGroupID:(NSString *) groupId;
+(void)saveTimelineOnServer:(Timeline*) timeline withCompletion:(PFBooleanResultBlock)completion;

@end

NS_ASSUME_NONNULL_END
