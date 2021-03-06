//
//  GroupDetailViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/28/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "EditGroupViewController.h"
#import "Member.h"
#import "MemberCell.h"
#import <Parse/Parse.h>
@import Parse;
@interface GroupDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *groupDescription;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (weak, nonatomic) IBOutlet PFImageView *groupImage;
@property (nonatomic,copy) NSArray <Member*>* members;
@end

@implementation GroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.titleBar.title = [self.group groupName];
    PFFileObject *groupImageFile = [self.group image];
    [groupImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.groupImage.image = [UIImage imageWithData:imageData];
        }
    }];
    self.groupImage.layer.cornerRadius = self.groupImage.frame.size.height /2;
    self.groupImage.layer.masksToBounds = YES;
    self.groupImage.layer.borderWidth = 0;
    self.groupCountLabel.text = [NSString stringWithFormat:@"%@", [self.group memberCount]];
    self.groupDescription.text = [self.group groupDescription];
    [self fetchMember];
}

-(void) fetchMember
{
    PFQuery *query = [Member query];
    [query whereKey:@"objectId" containedIn:[self.group membersInGroup] ];
    [query findObjectsInBackgroundWithBlock:^(NSArray<Member *>* _Nullable members, NSError * _Nullable error) {
        if(members)
        {
            self.members = members;
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    Group *group = self.group;
    EditGroupViewController  *viewController = [segue destinationViewController];
    viewController.group = group;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberCell"];
    cell.member = self.members[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.members.count;
}


@end
