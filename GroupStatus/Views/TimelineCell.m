//
//  TimelineCell.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/23/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "TimelineCell.h"
#import "Event.h"

@implementation TimelineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setEvent:(Event *)event
{
    _event = event;
    self.activityLabel.text = [event eventDescription];
    self.timeLabel.text = [event timeString];
    self.activityLabel.text = @"Event";
    
}
@end
