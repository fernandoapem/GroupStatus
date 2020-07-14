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
@property (nonatomic,strong) NSString *timelineID;
@property (nonatomic,strong) NSString *groupID;
@property (nonatomic,strong) NSNumber *eventCount;
+(void)createTimelinewithGroupID:(NSString * _Nullable)groupID withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end

NS_ASSUME_NONNULL_END
