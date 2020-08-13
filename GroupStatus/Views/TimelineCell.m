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


- (void)setEvent:(Event *)event
{
    _event = event;
    self.activityLabel.text = [event eventDescription];
    self.timeLabel.text = [event timeString];
    self.actionLabel.text = [event eventName];
    
    [self customizeView];
    
}
- (void) customizeView
{
    self.cellContainerView.layer.cornerRadius = 15;
    self.cellContainerView.layer.masksToBounds = true;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.frame = self.cellContainerView.bounds;
    gradient.colors = @[(id)[UIColor greenColor].CGColor, (id)[UIColor systemGreenColor].CGColor];
    [self.cellContainerView.layer insertSublayer:gradient atIndex:0];
}
@end
