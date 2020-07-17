//
//  JoinGroupViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/17/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "JoinGroupViewController.h"
#import "Member.h"
#import <Parse/Parse.h>
#import "Group.h"

@interface JoinGroupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation JoinGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)tapOnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)tapOnJoin:(id)sender {
  
    
    PFQuery *groupQuery = [Group query];
    Member *currentMember = [Member currentUser];
    
    
    
    [groupQuery whereKey:@"groupName" equalTo: self.nameTextField.text];
    [groupQuery findObjectsInBackgroundWithBlock:^(NSArray <Group *>* _Nullable groups, NSError * _Nullable error) {
        if(groups)
        {
            Group *currentGroup = groups[0];//get group with name
            
            int value = [currentGroup.memberCount intValue];
            currentGroup.memberCount = [NSNumber numberWithInt:value + 1]; //increment member count
            
            [currentGroup.members addObject:[currentMember objectId]];//add member to member array
            
            [currentGroup saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(succeeded)
                {
                    [currentMember addObject:[currentGroup objectId] forKey:@"groups"];
                    
                    int value = [currentMember.groupNumber intValue];
                    currentMember.groupNumber = [NSNumber numberWithInt:value + 1];
                    
                    [currentMember saveInBackground];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    NSLog(@"Group Joined!!!!");
                }
            }];
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    
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
