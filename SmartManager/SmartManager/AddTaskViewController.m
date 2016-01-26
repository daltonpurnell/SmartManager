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
    
    self.taskNameTextField.delegate = self;
    self.nextStepTextView.delegate = self;
    self.notesTextView.delegate = self;

    
}



#pragma mark - date pickers

- (void)changeDate:(UIDatePicker *)sender {
    NSLog(@"New Pickup Date: %@", sender.date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date = sender.date;
    [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    self.taskDueDateLabel.text = [NSString stringWithFormat:@"Task Due Date: %@", dateString];
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
    [[self.view viewWithTag:12] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, self.view.frame.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, self.view.frame.size.width, 216);
    CGRect blurViewTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216);
    
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [self.view viewWithTag:12].frame = blurViewTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
    
}

- (IBAction)firstDateButtonTapped:(id)sender {
    
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, self.view.frame.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216);
    CGRect blurViewTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIImageView *blurView = [UIImageView new];
    [blurView setFrame:CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216)];
    blurView.backgroundColor = [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];
    blurView.tag = 12;
    [self.view addSubview:blurView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, self.view.frame.size.width, 216)];
    datePicker.tag = 10;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.frame.size.width, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    blurView.frame = blurViewTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
    
    [self changeDate:datePicker];
}



- (void)changeReturnDate:(UIDatePicker *)sender {
    NSLog(@"New Return Date: %@", sender.date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date = sender.date;
    [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    self.nextStepDueDateLabel.text = [NSString stringWithFormat:@"Next Step Due Date: %@", dateString];
}

- (void)removeReturnViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
    [[self.view viewWithTag:12] removeFromSuperview];
}

- (void)dismissReturnDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, self.view.frame.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, self.view.frame.size.width, 216);
    CGRect blurViewTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216);
    
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [self.view viewWithTag:12].frame = blurViewTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeReturnViews:)];
    [UIView commitAnimations];
    
}

- (IBAction)secondDateButtonTapped:(id)sender {
    
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, self.view.frame.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216);
    CGRect blurViewTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissReturnDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIImageView *blurView = [UIImageView new];
    [blurView setFrame:CGRectMake(0, self.view.bounds.size.height-216, self.view.frame.size.width, 216)];
    blurView.tag = 12;
    blurView.backgroundColor = [UIColor colorWithRed:233/255.0 green:236/255.0 blue:243/255.0 alpha:1];
    [self.view addSubview:blurView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, self.view.frame.size.width, 216)];
    datePicker.tag = 10;
    [datePicker addTarget:self action:@selector(changeReturnDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.frame.size.width, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissReturnDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    blurView.frame = blurViewTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
    
    [self changeReturnDate:datePicker];

}





- (IBAction)doneButtonTapped:(id)sender {
    
    if (self.prioritySegmentedControl.selectedSegmentIndex == 0) {
        self.priority = @"1";
    } else if (self.prioritySegmentedControl.selectedSegmentIndex == 1) {
        
        self.priority = @"2";
    } else if (self.prioritySegmentedControl.selectedSegmentIndex == 2) {
        
        self.priority = @"3";
    }
    
    if ([self.taskNameTextField.text  isEqual: @""]) {
        
        // alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Please enter a name for this task" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if ([self.taskDueDateLabel.text  isEqual: @""]) {
        
        // alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Please choose a due date for this task" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if ([self.nextStepDueDateLabel.text  isEqual: @""]) {
        
        // alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Please choose a due date for this task's next step" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
    
    [[TaskController sharedInstance]createTaskWithName:self.taskNameTextField.text dueDate:self.taskDueDateLabel.text nextStep:self.nextStepTextView.text nextStepDueDate:self.nextStepDueDateLabel.text note:self.notesTextView.text priority:self.priority forEmployee:self.employee completion:^(BOOL succeeded, Task *task) {
        NSLog(@"Successfully saved to Parse");
    }];

    [self dismissViewControllerAnimated:YES completion:nil];
    
    }

}


- (IBAction)cancelButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}

- (void) textViewDidBeginEditing:(UITextView *) textView {
    [textView setText:@""];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
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
