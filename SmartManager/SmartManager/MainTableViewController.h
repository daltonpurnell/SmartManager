//
//  MainTableViewController.h
//  SmartManager
//
//  Created by Dalton on 7/28/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomExpandingCell.h"
@import AddressBook;
@import AddressBookUI;
@import Parse;
@import ParseUI;

@interface MainTableViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEmployeeButton;

@end
