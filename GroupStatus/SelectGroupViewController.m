//
//  SelectGroupViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/22/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "SelectGroupViewController.h"
#import "GroupCell.h"
#import "TimelineViewController.h"
#import "Group.h"
#import "Member.h"

@interface SelectGroupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *groups;

@end

@implementation SelectGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self fetchGroups];
    
}
-(void) fetchGroups
{
    Member *currentMember = [Member currentUser];
    PFQuery *groupQuery = [Group query];
    [groupQuery whereKey:@"objectId" containedIn:[currentMember groupsJoined]];
    [groupQuery findObjectsInBackgroundWithBlock:^(NSArray<Group *> * _Nullable groups, NSError * _Nullable error) {
        if(groups)
        {
            self.groups = groups;
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    groupQuery.limit = self.groups.count;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Group *group = self.groups[indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TimelineViewController *timelineController = [segue destinationViewController];
    timelineController.group = group;
    

}
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

           // ... Use the new data to update the data source ...
            [self fetchGroups];
           // Reload the tableView now that there is new data
            [self.tableView reloadData];
           // Tell the refreshControl to stop spinning
            [refreshControl endRefreshing];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    cell.group = self.groups[indexPath.row];
    [cell setGroup:cell.group];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}


@end
