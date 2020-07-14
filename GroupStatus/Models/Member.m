//
//  Member.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "Member.h"

@implementation Member
@dynamic groupNumber;
@dynamic groups;
@dynamic profilePicture;
@dynamic status;
+(void)createMember:(Member * _Nullable)member
{
    member.groupNumber = @(0);
    member.status = @"Starter";
    member.groups = [NSMutableArray new];
    member.profilePicture = nil;
    [member saveInBackgroundWithBlock: ^(BOOL succeeded, NSError * _Nullable error) {
      if (succeeded) {
          NSLog(@"Member Object created");
      } else {
          NSLog(@"%@",error.localizedDescription);
      }
    }];
}
@end
