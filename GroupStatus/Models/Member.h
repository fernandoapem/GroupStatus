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

@property (nonatomic,strong,readwrite) NSNumber *groupNumber;
@property (nonatomic,strong,readwrite) NSMutableArray *groups;
@property (nonatomic,strong,nullable,readwrite) PFFileObject *profilePicture;
@property (nonatomic,copy,readwrite) NSString *status;

-(instancetype) initWithStatus:(NSString *)status withUsername:(NSString *)username withPassword:(NSString *)password;
+(void)saveMemberOnServer:(Member*) member withCompletion:(PFBooleanResultBlock)completion;

@end

NS_ASSUME_NONNULL_END
