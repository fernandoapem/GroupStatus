//
//  GroupsViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/15/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "GroupsViewController.h"
#import <Parse/Parse.h>
#import "Group.h"
#import "GroupCell.h"
#import "Member.h"
#import "GroupDetailViewController.h"
#import "NavigationBarSetter.h"
@interface GroupsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation GroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [NavigationBarSetter customizeNavigatioBar:self];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self fetchGroups];
}
-(void) fetchGroups
{
    Member *currentMember = [Member currentUser];
    PFQuery *groupQuery = [Group query];
    [groupQuery whereKey:@"objectId" containedIn:[currentMember groupsJoined] ];
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
    groupQuery.limit = 10;
    
}

- (IBAction)tapOnAdd:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                   message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
     
    UIAlertAction* addAction = [UIAlertAction actionWithTitle:@"Create Group" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self performSegueWithIdentifier:@"createSegue" sender:nil];
        
    }];
    
    UIAlertAction* joinAction = [UIAlertAction actionWithTitle:@"Join Group" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self performSegueWithIdentifier:@"joinSegue" sender:nil];
        
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
    
    Group *group = self.groups[indexPath.row];
    GroupDetailViewController  *viewController = [segue destinationViewController];
    viewController.group = group;
     }
    
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
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

@end
