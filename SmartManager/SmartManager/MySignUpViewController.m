//
//  MySignUpViewController.m
//  ReturnPractice
//
//  Created by Dalton on 8/21/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "MySignUpViewController.h"

@interface MySignUpViewController ()

@end

@implementation MySignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    [self.signUpView setBackgroundColor:[UIColor colorWithRed:37/255.0 green:135/255.0 blue:211/255.0 alpha:1]];
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Returns3"]]];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"buttonColorClear.png"] forState:UIControlStateNormal];
    
    [self.signUpView.signUpButton setTintColor:[UIColor whiteColor]];
    
    // Remove text shadow
    CALayer *layer = self.signUpView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.signUpView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.signUpView.additionalField.layer;
    layer.shadowOpacity = 0.0;
    
    // Set field text color
    [self.signUpView.usernameField setTextColor:[UIColor whiteColor]];
    [self.signUpView.passwordField setTextColor:[UIColor whiteColor]];
    [self.signUpView.additionalField setTextColor:[UIColor whiteColor]];
    
    [self.signUpView.usernameField setBackgroundColor:[UIColor clearColor]];
    [self.signUpView.passwordField setBackgroundColor:[UIColor clearColor]];
    
    
    [Appearance initializeAppearanceDefaults];

}

-(void)viewDidLayoutSubviews {
    
    self.signUpView.signUpButton.clipsToBounds = YES;
    self.signUpView.signUpButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.signUpView.signUpButton.layer.borderWidth = 0.5f;
    
    self.signUpView.usernameField.clipsToBounds = YES;
    self.signUpView.usernameField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.signUpView.usernameField.layer.borderWidth = 0.5f;
    
    self.signUpView.passwordField.clipsToBounds = YES;
    self.signUpView.passwordField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.signUpView.passwordField.layer.borderWidth = 0.5f;
    
    
    [self.signUpView.dismissButton setTintColor:[UIColor whiteColor]];
    [self.signUpView.dismissButton setTitle:@"Cancel" forState:UIControlStateNormal];
}

@end
