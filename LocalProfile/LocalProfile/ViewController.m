//
//  ViewController.m
//  LocalProfile
//
//  Created by Jonathan King on 26/03/2014.
//  Copyright (c) 2014 Jonathan King. All rights reserved.
//

#import "ViewController.h"
#import "ProfileGenerator.h"
#import "AppDelegate.h"
#import "HTTPServer.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)installProfile:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Install", nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    // Hack the UIAlertViewStyleLoginAndPasswordInput to be an input for Name and Number - Really bad practice!
    
    // This is actually the login field
    UITextField *name = [alert textFieldAtIndex:0];
    name.placeholder = @"Name";
    name.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    // This is actually the password field
    UITextField *number = [alert textFieldAtIndex:1];
    number.placeholder = @"Phone Number";
    number.keyboardType = UIKeyboardTypePhonePad;
    number.secureTextEntry = NO;
    
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIAlertViewDelegate

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView*)alertView
{
    if(alertView.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput)
    {
        NSString *username = [[alertView textFieldAtIndex:0] text];
        NSString *password = [[alertView textFieldAtIndex:1] text];
        if ([username length] * [password length] == 0) return false;
        else return true;
    }
    else if (alertView.alertViewStyle == UIAlertViewStyleDefault)
        return true;
    else
        return false;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == [alertView cancelButtonIndex]) return;
    
    
    
    BOOL success = [ProfileGenerator generateProfileWithName:[alertView textFieldAtIndex:0].text andPhoneNumber:[alertView textFieldAtIndex:1].text];
    __weak AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UInt16 port = appDelegate.httpServer.port;
    NSLog(@"%u", port);
    if (success) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%u/profile.mobileconfig", port]]];
    else NSLog(@"Error generating profile");
}

@end
