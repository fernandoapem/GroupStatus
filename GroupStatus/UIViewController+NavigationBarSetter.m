//
//  NavigationBarSetter.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 8/7/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "UIViewController+NavigationBarSetter.h"
#import "ViewController.h"
@implementation UIViewController(NavigationBarSetter)


-(void) customizeNavigatioBar
{
     UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName :UIColor.systemGreenColor};
}
@end
