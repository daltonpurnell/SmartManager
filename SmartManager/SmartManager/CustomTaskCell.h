//
//  CustomTaskCell.h
//  SmartManager
//
//  Created by Dalton on 7/28/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *checkBox;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *TaskDueDateButton;
@property (weak, nonatomic) IBOutlet UILabel *nextStepLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextStepDueDateButton;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UITextView *nextStepTextView;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end
