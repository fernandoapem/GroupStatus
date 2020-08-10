//
//  GroupCell.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/16/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "GroupCell.h"
#import "Group.h"
@implementation GroupCell


- (void)setGroup:(Group *)group
{
    _group = group;
    
    self.descriptionLabel.text = [group groupDescription];
    self.groupNameLabel.text = [group groupName];
    self.memberCountLabel.text = [NSString stringWithFormat:@"%@", [group memberCount]];
    [self.groupImage loadInBackground];
    [self customizeView];
    
}
- (void) customizeView
{
    self.cellContainerView.layer.cornerRadius = 15;
    self.cellContainerView.layer.masksToBounds = true;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.frame = self.cellContainerView.bounds;
    gradient.colors = @[(id)[UIColor greenColor].CGColor, (id)[UIColor systemGreenColor].CGColor];
    [self.cellContainerView.layer insertSublayer:gradient atIndex:0];
}

@end
