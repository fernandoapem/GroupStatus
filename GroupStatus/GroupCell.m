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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setGroup:(Group *)group
{
    NSLog(@"HHHHHHHHH");
    _group = group;
    self.descriptionLabel.text = group.groupDescription;
    NSLog(@"%@",group.groupName);
    self.groupNameLabel.text = group.groupName;
    self.memberCountLabel.text = [NSString stringWithFormat:@"%@", group.memberCount];
    [self.groupImage loadInBackground];
}

@end
