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
    self.descriptionView.layer.cornerRadius = 10;
}
- (IBAction)onCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onCreateTap:(id)sender {
    
    Group *group = [[Group alloc] initWithGroupName:self.nameTextField.text description:self.descriptionView.text image:nil];
    Member *currentMember = [Member currentUser];
    
    [Group saveGroupOnServer:group completion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            [group addGrouptoMember];
            [group addNewMember:[currentMember objectId]];
            
        }
        else    
        {
            
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
