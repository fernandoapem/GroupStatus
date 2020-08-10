//
//  MemberCell.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/28/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
NS_ASSUME_NONNULL_BEGIN
@import Parse;
@interface MemberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet PFImageView *memberImage;
@property (nonatomic,strong) Member *member;
@property (weak, nonatomic) IBOutlet UIView *cellContainerView;

@end

NS_ASSUME_NONNULL_END
