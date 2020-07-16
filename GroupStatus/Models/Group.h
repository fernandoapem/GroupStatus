//
//  Group.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <Parse/Parse.h>
#import "Member.h"
NS_ASSUME_NONNULL_BEGIN

@interface Group : PFObject<PFSubclassing>
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSNumber *memberCount;
@property (nonatomic,strong) NSString *groupName;
@property (nonatomic,strong) NSString *groupDescription;
@property (nonatomic,strong,nullable) NSMutableArray *members;
@property (nonatomic, strong) PFFileObject *image;
+ (void) createGroup: ( NSString * _Nullable )name withDescription: (NSString * _Nullable)description withMember:(Member * _Nullable)member withImage: ( UIImage * _Nullable )image toGroup:(Group *)newGroup withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end

NS_ASSUME_NONNULL_END
