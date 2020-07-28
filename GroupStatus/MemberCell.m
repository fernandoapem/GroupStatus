//
//  MemberCell.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/28/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

-(void)setMember:(Member *)member
{
    _member = member;
    self.usernameLabel.text = [member username];
    self.statusLabel.text = [member status];
    self.memberImage = nil;
}

@end
