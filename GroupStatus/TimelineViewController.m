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
#import "EventDetailViewController.h"
#import "EditEventViewController.h"
#import "Member.h"
#import "Event.h"

@interface TimelineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *events;
@property (nonatomic,strong) TimelineCell *currentCell;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
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
    [Member saveMemberOnServer:currentMember completion:^(BOOL succeeded, NSError * _Nullable error) {
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
            self.group.timelineCreated = YES;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([sender isKindOfClass:[UITableViewCell class]]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        Event *event = self.timeline.events[indexPath.row];
        EventDetailViewController  *viewController = [segue destinationViewController];
        viewController.event = event;
        
    }
    if([sender isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Event *event = self.timeline.events[indexPath.row];
        EditEventViewController *viewController = [segue destinationViewController];
        viewController.event = event;
    }
}



- (void)beginRefresh:(UIRefreshControl *)refreshControl {

           // ... Use the new data to update the data source ...
            [self loadTimeline];
           // Reload the tableView now that there is new data
            [self.tableView reloadData];
           // Tell the refreshControl to stop spinning
            [refreshControl endRefreshing];
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineCell"];
    cell.event = self.timeline.events[indexPath.row];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                                 initWithTarget:self
                                               action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:longPress];
    
    return cell;
}

-  (void)handleLongPress:(UILongPressGestureRecognizer*)sender{
  if (sender.state == UIGestureRecognizerStateEnded) {
    NSLog(@"UIGestureRecognizerStateEnded");

   }
  else if (sender.state == UIGestureRecognizerStateBegan){
     NSLog(@"UIGestureRecognizerStateBegan.");

      [self performSegueWithIdentifier:@"editSegue" sender:sender];
      
      
   }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeline.events.count;
}


@end
