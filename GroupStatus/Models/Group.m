//
//  Group.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Group.h"
#import "Member.h"
#import <Parse/Parse.h>
@interface Group()
@property (readwrite) NSString *groupName;
@property (readwrite) NSString *groupDescription;
@property (nonatomic,strong,nullable,readwrite) NSMutableArray *members;
@end

@implementation Group
@dynamic   groupName;
@dynamic   groupDescription;
@dynamic   memberCount ;
@dynamic  members;
@dynamic   image;
@dynamic timelineCreated;

+ (nonnull NSString *)parseClassName {
    return @"Group";
}


+ (void) saveGroupOnServer: (Group *)group completion: (PFBooleanResultBlock  _Nullable)completion {
 
    [group saveInBackgroundWithBlock: completion];
}
-(void) addGrouptoMember
{
    Member *currentMember = [Member currentUser];
    [currentMember addNewGroup:self];
    
    int value = [currentMember.groupNumber intValue];
    currentMember.groupNumber = [NSNumber numberWithInt:value + 1];
    [currentMember saveInBackground];
}
-(void) addNewMember:(NSString *)memberId
{
    [self addObject:memberId forKey:@"members"];
    [self saveInBackground];
}
+(void) updateGroup:(Group *)group groupName:(NSString *)name
{
    group.groupName = name;
    
}
+(void) updateGroup:(Group *)group groupDescription:(NSString *)description
{
    group.groupDescription = description;
    
}
-(NSMutableArray *) membersInGroup
{
    return self.members;
}
-(instancetype)initWithGroupName:(NSString *)name description:(NSString *)description  image:(UIImage *)image {
    if(self = [super init])
    {
        self.groupName = name;
        self.groupDescription = description;
        self.memberCount = @(1);
        self.image = [self.class getPFFileFromImageGiven:image];
        self.members = [NSMutableArray new];
        self.timelineCreated = NO;
        

    }
    return self;
}
+(void)updateProfilePic:(UIImage * _Nullable)image forMember:(Group *)group completion:(PFBooleanResultBlock  _Nullable)completion {

    group.image  = [self getPFFileFromImageGiven:image];
    [group saveInBackgroundWithBlock:completion];
}

+(PFFileObject *)getPFFileFromImageGiven: (UIImage * _Nullable)image {
    
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
