//
//  CreateGroupViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/16/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "Member.h"
#import "Group.h"

@interface CreateGroupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;

@end

@implementation CreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onCreateTap:(id)sender {
    Member *currentMember = [Member currentUser];
    Group *group = [Group new];
    [Group createGroup:self.nameTextField.text withDescription:self.descriptionView.text withMember:currentMember withImage:nil toGroup: group withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            [currentMember addObject:[group objectId] forKey:@"groups"];
            
            int value = [currentMember.groupNumber intValue];
            currentMember.groupNumber = [NSNumber numberWithInt:value + 1];
            [currentMember saveInBackground];
            NSLog(@"Group Created!!!!");
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
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
