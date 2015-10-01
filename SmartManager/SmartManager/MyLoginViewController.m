//
//  MyLoginViewController.m
//  ReturnPractice
//
//  Created by Dalton on 8/21/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "MyLoginViewController.h"

@interface MyLoginViewController ()

@end

@implementation MyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.logInView setBackgroundColor:[UIColor colorWithRed:37/255.0 green:135/255.0 blue:211/255.0 alpha:1]];
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"returns3"]]];
    self.logInView.logo.contentMode = UIViewContentModeScaleAspectFit;
    [self.logInView.logo setFrame:CGRectMake(self.logInView.frame.origin.x, self.logInView.frame.origin.y, self.logInView.frame.size.width, self.logInView.frame.size.height * 2)];
    self.logInView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"buttonColorGreen.png"] forState:UIControlStateNormal];
    
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"buttonColorClear.png"] forState:UIControlStateNormal];
    
    [self.logInView.signUpButton setTintColor:[UIColor whiteColor]];



// Remove text shadow
CALayer *layer = self.logInView.usernameField.layer;
layer.shadowOpacity = 0.0;
layer = self.logInView.passwordField.layer;
layer.shadowOpacity = 0.0;

// Set field text color
    [self.logInView.usernameField setTextColor:[UIColor whiteColor]];
    [self.logInView.passwordField setTextColor:[UIColor whiteColor]];


// Set text field background color
    [self.logInView.usernameField setBackgroundColor:[UIColor clearColor]];
    [self.logInView.passwordField setBackgroundColor:[UIColor clearColor]];
    
    [Appearance initializeAppearanceDefaults];
}

-(void)viewDidLayoutSubviews {

    self.logInView.signUpButton.clipsToBounds = YES;
    self.logInView.signUpButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.logInView.signUpButton.layer.borderWidth = 0.5f;

    self.logInView.usernameField.clipsToBounds = YES;
    self.logInView.usernameField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.logInView.usernameField.layer.borderWidth = 0.5f;
    
    self.logInView.passwordField.clipsToBounds = YES;
    self.logInView.passwordField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.logInView.passwordField.layer.borderWidth = 0.5f;
    
    
    [self.logInView.dismissButton setTintColor:[UIColor whiteColor]];
    [self.logInView.dismissButton setTitle:@"Cancel" forState:UIControlStateNormal];
}

@end
