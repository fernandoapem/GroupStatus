//
//  AppDelegate.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/13/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Member.h"
#import "LoginViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "SceneDelegate.h"
#import "GroupsViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        configuration.applicationId = @"groupstatusfbu";
        configuration.server = @"https://groupstatusfbu.herokuapp.com/parse";
    }];
    
    [Parse initializeWithConfiguration:config];
    
    [GIDSignIn sharedInstance].clientID = @"185786784499-2sc4ccghhlt0o10uuvb3kj926300o18h.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].delegate = self;
   
    // Override point for customization after application launch.
    return YES;
}
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
  if (error != nil) {
    if (error.code == kGIDSignInErrorCodeHasNoAuthInKeychain) {
      NSLog(@"The user has not signed in before or they have since signed out.");
    } else {
      NSLog(@"%@", error.localizedDescription);
    }
    return;
  }
  else{

    Member *member = [[Member alloc] initWithStatus:@"Starter" username:user.profile.givenName password:user.profile.familyName googleUser:YES];

    [member signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            NSLog(@"User signed up successfully");
            [Member saveMemberOnServer:member completion:^(BOOL succeeded, NSError * _Nullable error) {
                if(succeeded){
                    NSLog(@"Member created");
                    
                }
            }];
        }
        else
        {
            [PFUser logInWithUsernameInBackground:user.profile.givenName password:user.profile.familyName block:^(PFUser * user, NSError *  error) {
                if (error != nil) {
                    NSLog(@"%@",error.localizedDescription);
                } else {
                    NSLog(@"User logged in successfully");
                    [[NSNotificationCenter defaultCenter ] postNotificationName:@"Google Logged in" object:nil];
                    
                }
            }];
        }
    }];
  }

}
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
  // Perform any operations when the user disconnects from app here.
  // ...

}
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
  return [[GIDSignIn sharedInstance] handleURL:url];
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
