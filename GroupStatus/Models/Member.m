//
//  Member.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Member.h"
#import "Group.h"
@import Parse;
@interface Member()

@property (nonatomic,strong,readwrite) NSMutableArray<Group *>  *groups;
@end

@implementation Member
@dynamic groupNumber;
@dynamic groups;
@dynamic profilePicture;
@dynamic status;
@dynamic currentTimelineId;
@dynamic isGoogleUser;

-(instancetype)initWithStatus:(NSString *)status username:(NSString *)username password:(NSString *)password googleUser:(BOOL) isGoogleUser
{
    if(self = [super init])
    {
        self.username = username;
        self.password = password;
        self.groupNumber = @(0);
        self.status = status;
        self.groups = [NSMutableArray new];
        self.profilePicture = nil;
        self.currentTimelineId = @"";
        self.isGoogleUser = isGoogleUser;
    }
    return self;
}
+(void) saveMemberOnServer:(Member *)member completion:(PFBooleanResultBlock)completion
{
    [member saveInBackgroundWithBlock:completion];
}
-(void) addNewGroup:(Group *)group
{
    [self addObject:[group objectId] forKey:@"groups"];
}
-(NSMutableArray<Group*> *)groupsJoined
{
    return self.groups;
}

+(void)updateProfilePic:(UIImage * _Nullable)image forMember:(Member *)member completion:(PFBooleanResultBlock  _Nullable)completion {

    member.profilePicture  = [self getPFFileFromImage:image];
    [member saveInBackgroundWithBlock:completion];
}
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}
@end
