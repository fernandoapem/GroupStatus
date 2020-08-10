//
//  MemberCell.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/28/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "MemberCell.h"
#import "Member.h"
@implementation MemberCell

-(void)setMember:(Member *)member
{
    self.usernameLabel.text = [member username];
    self.statusLabel.text = [member status];
    
    self.memberImage.layer.cornerRadius = self.memberImage.frame.size.height /2;
    self.memberImage.layer.masksToBounds = YES;
    self.memberImage.layer.borderWidth = 0;
    PFFileObject *userImageFile = [member profilePicture];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.memberImage.image = [UIImage imageWithData:imageData];
        }
    }];
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
    [self.cellContainerView addSubview:self.usernameLabel];
    [self.cellContainerView addSubview:self.statusLabel];
    [self.cellContainerView addSubview:self.memberImage];
}

@end
