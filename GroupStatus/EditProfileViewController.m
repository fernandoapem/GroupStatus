//
//  EditProfileViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/28/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Member.h"
#import <Parse/Parse.h>
@import Parse;
@interface EditProfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
@property (nonatomic) BOOL didSelectEdit;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.member = [Member currentUser];
    self.didSelectEdit = NO;
}
- (IBAction)onCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)onUpdateTap:(id)sender {
    if(![self.statusTextField.text isEqualToString:@""])
    {
        self.member.status = self.statusTextField.text;
    }
    [self.member saveInBackground];
    if(self.didSelectEdit)
    {
    UIImage *resized = [self resizeImage:self.profilePicture.image withSize:CGSizeMake(2000.0, 2000.0)];
    [Member updateProfilePic:resized forMember:self.member completion:^(BOOL succeeded, NSError * _Nullable error) {
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onEditPictureTap:(id)sender {
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
    [imagePickerVC setOverrideUserInterfaceStyle:UIUserInterfaceStyleDark];
    imagePickerVC.view.tintColor = [UIColor systemGreenColor];
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
    self.profilePicture.image = editedImage;
    
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
