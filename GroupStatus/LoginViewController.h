//
//  LoginViewController.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "ViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : ViewController
@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

@end

NS_ASSUME_NONNULL_END
