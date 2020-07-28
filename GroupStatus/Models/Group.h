//
//  Group.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Group : PFObject<PFSubclassing>
@property (nonatomic,strong,readwrite) NSNumber *memberCount;
@property (nonatomic,copy,readonly) NSString *groupName;
@property (nonatomic,copy,readonly) NSString *groupDescription;
@property (nonatomic, strong,readwrite) PFFileObject *image;
@property (nonatomic) BOOL timelineCreated;
+(PFFileObject *)getPFFileFromImageGiven: (UIImage * _Nullable)image;
-(instancetype) initWithGroupName:( NSString *) name description: (NSString * )description image: ( UIImage * _Nullable )image;
+ (void) saveGroupOnServer:(Group *)group completion: (PFBooleanResultBlock  _Nullable)completion;
-(void) addGrouptoMember;
-(void) addNewMember:(NSString *)memberId;
-(NSMutableArray *) membersInGroup;

@end

NS_ASSUME_NONNULL_END
