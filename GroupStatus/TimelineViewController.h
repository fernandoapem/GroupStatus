//
//  TimelineViewController.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/15/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "ViewController.h"
#import "Timeline.h"
#import "Group.h"
NS_ASSUME_NONNULL_BEGIN

@interface TimelineViewController : ViewController
@property (nonatomic,strong) Timeline *timeline;
@property (nonatomic,strong) Group *group;
@end

NS_ASSUME_NONNULL_END
