//
//  EditEventViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/31/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "EditEventViewController.h"
#import "Event.h"

@interface EditEventViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *linkTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation EditEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventNameLabel.text = [NSString stringWithFormat:@"Edit event: %@",[self.event eventName]];
}
- (IBAction)onCancelTap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)onEditTap:(id)sender {
    
    [self setInputValues];
    [Event saveEventOnServer:self.event withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            NSLog(@"Event Updated");
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setInputValues
{
    if(![self.eventNameTextField.text isEqualToString:@""])
    {
        [Event updateEvent:self.event eventName:self.eventNameTextField.text];
    }
    if(![self.eventDescriptionTextView.text isEqualToString:@""])
    {
        [Event updateEvent:self.event eventDescription:self.eventDescriptionTextView.text];
    }
    if(![self.linkTextField.text isEqualToString:@""])
    {
        [Event updateEvent:self.event link:self.linkTextField.text];
    }
    if(self.datePicker != nil)
    {
        [Event updateEvent:self.event time:self.datePicker.date];
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
