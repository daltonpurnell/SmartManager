//
//  AddTaskViewController.m
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Appearance.h"
#import "TaskController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Appearance initializeAppearanceDefaults];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:80/255.0 green:157/255.0 blue:64/255.0 alpha:1]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.nextStepTextView.backgroundColor = [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];
    self.notesTextView.backgroundColor = [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];

    
    self.imageView1.backgroundColor = [UIColor whiteColor];
    self.imageView2.backgroundColor = [UIColor whiteColor];
    self.imageView3.backgroundColor = [UIColor whiteColor];
    
    // create drop shadows
    self.imageView1.layer.shadowColor = [UIColor grayColor].CGColor;
    self.imageView1.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.imageView1.layer.shadowOpacity = 1;
    self.imageView1.layer.shadowRadius = 1.0;
    self.imageView1.clipsToBounds = NO;
    
    self.imageView2.layer.shadowColor = [UIColor grayColor].CGColor;
    self.imageView2.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.imageView2.layer.shadowOpacity = 1;
    self.imageView2.layer.shadowRadius = 1.0;
    self.imageView2.clipsToBounds = NO;
    
    self.imageView3.layer.shadowColor = [UIColor grayColor].CGColor;
    self.imageView3.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.imageView3.layer.shadowOpacity = 1;
    self.imageView3.layer.shadowRadius = 1.0;
    self.imageView3.clipsToBounds = NO;
    
    self.nextStepTextView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.nextStepTextView.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.nextStepTextView.layer.shadowOpacity = 1;
    self.nextStepTextView.layer.shadowRadius = 1.0;
    self.nextStepTextView.clipsToBounds = NO;
    
    self.notesTextView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.notesTextView.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.notesTextView.layer.shadowOpacity = 1;
    self.notesTextView.layer.shadowRadius = 1.0;
    self.notesTextView.clipsToBounds = NO;
    
}

- (IBAction)doneButtonTapped:(id)sender {
    
    
// create task
    
    
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
