//
//  Member.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <Parse/Parse.h>
#import "Group.h"
NS_ASSUME_NONNULL_BEGIN

@interface Member : PFUser<PFSubclassing>

@property (nonatomic,strong,readwrite) NSNumber *groupNumber;
@property (nonatomic,strong,nullable,readwrite) PFFileObject *profilePicture;
@property (nonatomic,copy,readwrite) NSString *status;
@property (nonatomic) BOOL isGoogleUser;
@property (nonatomic,copy,readwrite) NSString *currentTimelineId;
- (void)addNewGroup:(Group *)group;
-(NSMutableArray<Group*> *)groupsJoined;
-(instancetype) initWithStatus:(NSString *)status username:(NSString *)username password:(NSString *)password googleUser:(BOOL) isGoogleUser;
+(void)saveMemberOnServer:(Member*) member completion:(PFBooleanResultBlock)completion;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
+(void)updateProfilePic:(UIImage * _Nullable)image forMember:(Member *)member completion:(PFBooleanResultBlock  _Nullable)completion;
@end

NS_ASSUME_NONNULL_END
