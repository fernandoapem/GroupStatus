//
//  Member.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Member : PFUser<PFSubclassing>
@property (nonatomic,strong) NSNumber *groupNumber;
@property (nonatomic,strong) NSMutableArray *groups;
@property (nonatomic,strong,nullable) PFFileObject *profilePicture;
@property (nonatomic,strong) NSString *status;
+(void) createMember:(Member * _Nullable)member;

@end

NS_ASSUME_NONNULL_END
