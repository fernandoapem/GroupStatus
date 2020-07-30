//
//  ProfileViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/15/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "ProfileViewController.h"
#import "Member.h"
#import <Parse/Parse.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "LoginViewController.h"
#import "SceneDelegate.h"
@import Parse;
@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupCountLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    Member *currentMember = [Member currentUser];
    self.usernameLabel.text = [currentMember username];
    self.statusLabel.text = [currentMember status];
    self.groupCountLabel.text =[NSString stringWithFormat:@"%@", [currentMember groupNumber]];
}
- (IBAction)tapOnLogOut:(id)sender {
    Member *currentMember = [Member currentUser];
    
    
    if(currentMember.isGoogleUser)
    {
         [[GIDSignIn sharedInstance] signOut];
        SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        sceneDelegate.window.rootViewController = loginViewController;
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {

        }];

    }
    else
    {
        SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        sceneDelegate.window.rootViewController = loginViewController;

        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {

        }];
    }
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
