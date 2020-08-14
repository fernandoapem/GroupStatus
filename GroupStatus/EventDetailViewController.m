//
//  EventDetailViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/29/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "EventDetailViewController.h"
#import "UIViewController+NavigationBarSetter.h"
#import "KILabel.h"
@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkTagLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView.layer.cornerRadius = 15;
    
    self.containerView.layer.masksToBounds = true;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.frame = self.containerView.bounds;
    gradient.colors = @[(id)[UIColor greenColor].CGColor, (id)[UIColor systemGreenColor].CGColor];
    [self.containerView.layer insertSublayer:gradient atIndex:0];
    
    self.linkLabel.layer.cornerRadius =10;
    self.linkLabel.editable = NO;
    self.linkLabel.dataDetectorTypes= UIDataDetectorTypeAll;
    self.title= [self.event eventName];
    [self customizeNavigatioBar];
    self.descriptionLabel.text = [self.event eventDescription];
    if([[self.event link] isEqualToString:@""])
    {
        self.linkTagLabel.alpha = 0;
        self.linkLabel.alpha = 0;
    }
    else
    {
        self.linkLabel.text = [self.event link];
       
    }
    self.timeLabel.text = [self.event timeString];
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
