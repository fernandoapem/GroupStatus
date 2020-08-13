//
//  EditGroupViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 8/11/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "EditGroupViewController.h"
#import "EditGroupView.h"
#import "Group.h"

@interface EditGroupViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong,nonatomic) EditGroupView *view;
@property (nonatomic) BOOL didSelectEdit;

@end

@implementation EditGroupViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = self.group.groupName;
    
    [self.view.editProfilePictureButton addTarget:self action:@selector(onEditPictureTap) forControlEvents:UIControlEventTouchDown];
    [self.view.updateGroupButton addTarget:self action:@selector(onUpdateTap) forControlEvents:UIControlEventTouchDown];
    
}
-(void)loadView
{
    self.view = [EditGroupView new];
}

-(void)onUpdateTap
{
    if(![self.view.nameTextField.text isEqualToString:@""])
    {
        [Group updateGroup:self.group groupName:self.view.nameTextField.text];
        
    }
    if(![self.view.descriptionTextView.text isEqualToString:@""])
    {
        [Group updateGroup:self.group groupDescription:self.view.descriptionTextView.text];
        
    }
    [self.group saveInBackground];
    if(self.didSelectEdit)
    {
        UIImage *resized = [self resizeImage:self.view.profilePicture.image withSize:CGSizeMake(2000.0, 2000.0)];
        [Group updateProfilePic:resized forMember:self.group completion:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded)
            {
                NSLog(@"Update successfull!!");
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onEditPictureTap{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.didSelectEdit = YES;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    //    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    self.view.profilePicture.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
