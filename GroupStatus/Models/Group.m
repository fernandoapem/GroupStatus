//
//  Group.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Group.h"
#import "Member.h"

@implementation Group
@dynamic groupId;
@dynamic groupName;
@dynamic groupDescription;
@dynamic members;
@dynamic memberCount;
@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"Group";
}

+ (void) createGroup: ( NSString * _Nullable )name withDescription: (NSString * _Nullable)description withMember:(Member * _Nullable)member withImage: ( UIImage * _Nullable )image toGroup:(Group *)newGroup withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    newGroup.groupName =name;
    newGroup.groupDescription =description;
    newGroup.memberCount = @(1);
    newGroup.members = [NSMutableArray new];
    newGroup.image = [self getPFFileFromImage:image];
    
    
    [newGroup saveInBackgroundWithBlock: completion];
    
   
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
