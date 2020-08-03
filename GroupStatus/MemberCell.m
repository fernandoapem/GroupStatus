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
    
}

@end
