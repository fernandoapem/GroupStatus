//
//  GroupCell.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/16/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
NS_ASSUME_NONNULL_BEGIN
@import Parse;
@interface GroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *memberCountLabel;
@property (nonatomic,strong) Group *group;
@property (weak, nonatomic) IBOutlet PFImageView *groupImage;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;

@end

NS_ASSUME_NONNULL_END
