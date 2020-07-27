//
//  Group.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Group.h"

#import <Parse/Parse.h>
@interface Group()
@property (readwrite) NSString *groupName;
@property (readwrite) NSString *groupDescription;
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


+ (void) saveGroupOnServer: (Group *)group withCompletion: (PFBooleanResultBlock  _Nullable)completion {
 
    [group saveInBackgroundWithBlock: completion];
}

-(instancetype)initWithGroupName:(NSString *)name Description:(NSString *)description  Image:(UIImage *)image {
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
