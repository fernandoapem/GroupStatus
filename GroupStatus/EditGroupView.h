//
//  EditGroupView.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 8/11/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface EditGroupView : UIView
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextView *descriptionTextView;
@property (nonatomic,strong) PFImageView *profilePicture;
@property (nonatomic,strong) UIButton *editProfilePictureButton;
@property (nonatomic,strong) UIButton *updateGroupButton;

@end

NS_ASSUME_NONNULL_END
