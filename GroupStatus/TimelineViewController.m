//
//  TimelineViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/15/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "TimelineViewController.h"
#import <Parse/Parse.h>
#import "Group.h"
#import "Timeline.h"

@interface TimelineViewController ()
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.groupNameLabel.text = self.group.groupName;
    Timeline *newTimeline = [[Timeline alloc] initWithGroupID:[self.group objectId]];
    self.timeline = newTimeline;
    
    
    if(!self.group.timelineCreated){
        [Timeline saveTimelineOnServer:self.timeline withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Timeline created");
            self.group.timelineCreated = @(YES);
            [self.group saveInBackground];
        }
    }];
        
    }
    else
    {
        PFQuery *query = [Timeline query];
        [query whereKey:@"groupID" equalTo:[self.group objectId]];
        [query findObjectsInBackgroundWithBlock:^(NSArray <Timeline *>* _Nullable timelineArray, NSError * _Nullable error) {
            self.timeline = timelineArray[0];
            
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
