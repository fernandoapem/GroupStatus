//
//  CreateEventViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/23/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "CreateEventViewController.h"
#import "Event.h"
#import "Timeline.h"
#import "Member.h"
#import <Parse/Parse.h>
@interface CreateEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *linkTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    self.descriptionTextView.layer.cornerRadius = 10;
    [self fetchCurrentTimeline];
}
- (IBAction)tapOnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)tapOnCreate:(id)sender {
    
    Event *event = [[Event alloc] initWithEventName:self.nameTextField.text description:self.descriptionTextView.text time:self.datePicker.date timelineId:[self.timeline objectId] link:self.linkTextField.text];
    [Event saveEventOnServer:event withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        { 
            [self.timeline addEvent:event];
        }
        else
        {
            
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) fetchCurrentTimeline
{
    Member *currentMember = [Member currentUser];
    PFQuery *query = [Timeline query];
    [query whereKey:@"objectId" equalTo:currentMember.currentTimelineId];
    [query findObjectsInBackgroundWithBlock:^(NSArray <Timeline *>* _Nullable timelines, NSError * _Nullable error) {
        if(timelines){
            self.timeline = timelines[0];
            
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
