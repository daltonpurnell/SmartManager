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
@import MessageUI;
@import CoreLocation;


static NSString *const NoPhoneNumberNotificationKey = @"No phone number";

@interface MainTableViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UIScrollViewDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate> {
    
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEmployeeButton;
@property (strong, nonatomic) Employee *employee;


@end
