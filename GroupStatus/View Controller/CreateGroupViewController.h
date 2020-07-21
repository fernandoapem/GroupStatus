//
//  CreateGroupViewController.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/16/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "ViewController.h"
#import "Member.h"
#import "Group.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateGroupViewController : ViewController
-(void) addMember:(Member *)currentMember toGroup:(Group*)group;

@end

NS_ASSUME_NONNULL_END
