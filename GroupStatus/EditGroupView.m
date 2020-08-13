//
//  EditGroupView.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 8/11/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "EditGroupView.h"
#import "UIViewController+NavigationBarSetter.h"
@import Parse;
@interface EditGroupView()


@end

@implementation EditGroupView


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = UIColor.darkGrayColor;
        
        self.nameLabel = [UILabel new];
        self.descriptionLabel = [UILabel new];
        self.nameTextField = [UITextField new];
        self.descriptionTextView = [UITextView new];
        self.profilePicture = [PFImageView new];
        self.editProfilePictureButton = [UIButton new];
        self.updateGroupButton = [UIButton new];
        
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.descriptionLabel];
        [self addSubview:self.nameTextField];
        [self addSubview:self.descriptionTextView];
        [self addSubview:self.profilePicture];
        [self addSubview:self.editProfilePictureButton];
        [self addSubview:self.updateGroupButton];
        
        
        self.nameLabel.text = @"Edit Name:";
        self.descriptionLabel.text = @"Edit Description:";
        
        
        [self.editProfilePictureButton setTitle:@"Edit Profile Picture" forState:UIControlStateNormal ];
        [self.editProfilePictureButton setTitleColor:[UIColor systemGreenColor] forState:UIControlStateNormal];
        
        [self.updateGroupButton setTitle:@"Update Group" forState:UIControlStateNormal];
        [self.updateGroupButton setTitleColor:[UIColor systemGreenColor] forState:UIControlStateNormal];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.frame = CGRectMake(30, 270, 100, 30);
    self.nameLabel.textColor = [UIColor whiteColor];
    
    self.descriptionLabel.frame = CGRectMake(30, 350, 135, 30);
    self.descriptionLabel.textColor = [UIColor whiteColor];
    
    self.editProfilePictureButton.frame = CGRectMake(135, 230, 150, 20);
    self.profilePicture.frame = CGRectMake(135, 130, 150, 100);
    self.profilePicture.image = [UIImage imageNamed:@"group2"];
    
    self.updateGroupButton.frame = CGRectMake(150, 530, 130, 20);
    
    self.nameTextField.frame = CGRectMake(150, 270, 220, 30);
    self.nameTextField.placeholder = @"Group Name";
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.textColor = [UIColor blackColor];
    
    self.descriptionTextView.frame = CGRectMake(30, 385, 345, 100);
    self.descriptionTextView.backgroundColor = [UIColor whiteColor];
    self.descriptionTextView.textColor = [UIColor blackColor];
    self.descriptionTextView.layer.cornerRadius = 5;
    
    
    
    
}

- (CGSize)sizeThatFits:(CGSize) size
{
    CGFloat const width = size.width;
    CGFloat const height = size.height;
    
    return CGSizeMake(width, height);
}

@end
