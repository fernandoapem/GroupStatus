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

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)onUpdateTap:(id)sender {
    Member *currentMember = [Member currentUser];
    currentMember.status = self.statusTextField.text;
    [currentMember saveInBackground];
    
    
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
