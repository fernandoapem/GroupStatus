//
//  TimelineCell.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/23/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
NS_ASSUME_NONNULL_BEGIN

@interface TimelineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (nonatomic,strong) Event *event;
@property (weak, nonatomic) IBOutlet UIView *cellContainerView;

@end

NS_ASSUME_NONNULL_END
