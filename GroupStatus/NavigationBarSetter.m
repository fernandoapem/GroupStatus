//
//  NavigationBarSetter.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 8/7/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "NavigationBarSetter.h"
#import "ViewController.h"
@implementation NavigationBarSetter

+(void) customizeNavigatioBar:(ViewController *)viewController
{
     UINavigationBar *navigationBar = viewController.navigationController.navigationBar;
    navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName :UIColor.systemGreenColor};
}
@end
