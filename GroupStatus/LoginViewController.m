//
//  LoginViewController.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 7/14/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "LoginViewController.h"
#import "Member.h"
#import "Group.h"
#import "Timeline.h"
#import "Event.h"
#import <Parse/Parse.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "UITextField+Shake.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [GIDSignIn sharedInstance].presentingViewController = self;
    
    // Automatically sign in the user.
    [[GIDSignIn sharedInstance] restorePreviousSignIn];
    
    
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segueIntoVC) name:@"Google Logged in" object:nil];
    if([signIn currentUser])
    {
        
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        
    }
    
    
}

- (void) segueIntoVC
{
    [self performSegueWithIdentifier:@"loginSegue" sender:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    Member *currentMember = [Member currentUser];
    if(currentMember.isGoogleUser && currentMember)
    {
        
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        
    }
}

- (IBAction)tapOnSignUp:(id)sender {
    Member *member = [[Member alloc] initWithStatus:@"Starter" username:self.usernameTextField.text password:self.passwordTextField.text googleUser:NO];
    
    
    [member signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            NSLog(@"User signed up successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            [Member saveMemberOnServer:member completion:^(BOOL succeeded, NSError * _Nullable error) {
                if(succeeded){
                    NSLog(@"Member created");
                }
            }];
            
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    
}
- (IBAction)tapOnLogIn:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    if([self.usernameTextField.text isEqual:@""])
    {
        [self.usernameTextField shake:10 withDelta:5];
        
    }
    if([self.passwordTextField.text isEqual:@""])
    {
        [self.passwordTextField shake:10 withDelta:5];
    }
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    
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
