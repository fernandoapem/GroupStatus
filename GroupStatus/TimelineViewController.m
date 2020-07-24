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
#import "TimelineCell.h"
#import "CreateEventViewController.h"
#import "Member.h"
@interface TimelineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *events;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self loadTimeline];

    self.titleBar.title = [NSString stringWithFormat:@"%@'s Timeline",self.group.groupName];

    
}
-(void) fetchEvents
{
    PFQuery *query = [Event query];
    [query whereKey:@"objectId" containedIn:self.timeline.events];
    [query findObjectsInBackgroundWithBlock:^(NSArray<Event *>* _Nullable events, NSError * _Nullable error) {
        if(events)
        {
            self.timeline.events = [events mutableCopy];
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    
}
-(void) updateTimeline
{
    Member *currentMember = [Member currentUser];
    currentMember.currentTimelineId = [self.timeline objectId];
    [Member saveMemberOnServer:currentMember withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            NSLog(@"Timeline Updated");
        }
        else
        {
            
        }
    }];
    
}
-(void) loadTimeline
{
    Timeline *newTimeline = [[Timeline alloc] initWithGroupID:[self.group objectId]];
    self.timeline = newTimeline;
    
   
    if(!self.group.timelineCreated){
        [Timeline saveTimelineOnServer:self.timeline withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Timeline created");
            [self updateTimeline];
            self.group.timelineCreated = @(YES);
            [self.group saveInBackground];
            [self fetchEvents];
        }
    }];
        
    }
    else
    {
        PFQuery *query = [Timeline query];
        [query whereKey:@"groupID" equalTo:[self.group objectId]];
        [query findObjectsInBackgroundWithBlock:^(NSArray <Timeline *>* _Nullable timelineArray, NSError * _Nullable error) {
            self.timeline = timelineArray[0];
            [self updateTimeline];
            [self fetchEvents];

        }];

    }
}
- (IBAction)tapOnAdd:(id)sender {
   UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                   message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
     
    UIAlertAction* addAction = [UIAlertAction actionWithTitle:@"Create Event" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        
       
        [self performSegueWithIdentifier:@"eventSegue" sender:nil];
        
    }];
    
    UIAlertAction* joinAction = [UIAlertAction actionWithTitle:@"Create Activity" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self performSegueWithIdentifier:@"activitySegue" sender:nil];
        
    }];
     
    [alert addAction:addAction];
    [alert addAction:joinAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  
}
*/



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineCell"];
    cell.event = self.timeline.events[indexPath.row];
    [cell setEvent:cell.event];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeline.events.count;
}


@end
