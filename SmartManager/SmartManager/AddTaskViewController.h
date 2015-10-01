//
//  AddTaskViewController.h
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *NextStepDueDateButton;
@property (weak, nonatomic) IBOutlet UITextView *nextStepTextView;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@end
