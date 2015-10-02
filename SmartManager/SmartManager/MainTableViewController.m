//
//  MainTableViewController.m
//  SmartManager
//
//  Created by Dalton on 7/28/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "MainTableViewController.h"
#import "Appearance.h"
#import "EmployeeController.h"

@interface MainTableViewController () <UITableViewDelegate, UITableViewDataSource, textButtonTappedDelegate, emailButtonTappedDelegate>

@property (strong, nonatomic) CustomExpandingCell *customCell;
@property (strong, nonatomic) NSString *savedEmail;
@property (strong, nonatomic) NSString *savedPhoneNumber;
@property (strong, nonatomic) NSString *savedAddress;
@property (strong, nonatomic) NSString *savedFirstName;
@property (strong, nonatomic) NSString *savedLastName;
@property (strong, nonatomic) NSIndexPath *selectedCellIndexPath;
@property (strong, nonatomic) PFFile *savedPhoto;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForNotifications];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [Appearance initializeAppearanceDefaults];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:80/255.0 green:157/255.0 blue:64/255.0 alpha:1]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.addEmployeeButton setTintColor:[UIColor whiteColor]];
    self.title = @"SMART Manager";
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor],
                                                           NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"SystemFont" size: 30.0],
                                                           NSFontAttributeName,
                                                           nil]];
    
    
    
    ABAddressBookRef addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        NSLog(@"Access to contacts %@ by user", granted ? @"granted" : @"denied");
    });

    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) { // No user logged in

                // parse log in
                        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
                        [logInViewController setDelegate:self];
                        [logInViewController setFields:PFLogInFieldsUsernameAndPassword
                         | PFLogInFieldsSignUpButton
                         | PFLogInFieldsLogInButton
                         | PFLogInFieldsDismissButton
                         | PFLogInFieldsUsernameAndPassword];
    
                        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
                        [signUpViewController setDelegate:self];
                        [signUpViewController setFields:PFSignUpFieldsUsernameAndPassword
                         | PFSignUpFieldsDismissButton
                         | PFSignUpFieldsSignUpButton];
    
                        [logInViewController setSignUpController:signUpViewController];
    
                        [self presentViewController:logInViewController animated:YES completion:^{
    
                            // nothing
                        }];
    }
    
}


    


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [EmployeeController sharedInstance].employees.count;
}



- (CustomExpandingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomExpandingCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Employee *employee = [EmployeeController sharedInstance].employees[indexPath.row];
    customCell.employee = employee;
    
    customCell.indexPath = indexPath;
    customCell.delegate = self;
    customCell.emailDelegate = self;
    
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *previousSelectedIndexPath = self.selectedCellIndexPath;  // <- save previously selected cell
    self.selectedCellIndexPath = indexPath;
    if (previousSelectedIndexPath) { // <- reload previously selected cell (if not nil)
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousSelectedIndexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedCellIndexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.selectedCellIndexPath != nil
       && [self.selectedCellIndexPath compare:indexPath] == NSOrderedSame)
       
        return self.view.frame.size.height;
    
    return 70;
}


- (IBAction)addEmployee:(id)sender {

    // Show ABPeoplePickerNavigationController
    ABPeoplePickerNavigationController *picker = [ABPeoplePickerNavigationController new];
    picker.peoplePickerDelegate = self;
    picker.displayedProperties = @[@(kABPersonEmailProperty)];
//    picker.predicateForEnablingPerson = [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];
//    picker.predicateForSelectionOfPerson = [NSPredicate predicateWithFormat:@"emailAddresses.@count = 1"];
    
    [self presentViewController:picker animated:YES completion:nil];

    NSLog(@"People picker launched");
//    }
}


#pragma mark - ABPeoplePickerNavigationControllerDelegate methods

// A selected person is returned with this method.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    [self didSelectPerson:person identifier:kABMultiValueInvalidIdentifier];
}


// A selected person and property is returned with this method.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    [self didSelectPerson:person identifier:identifier];
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    
}



#pragma mark - ABPeoplePickerNavigationController helper methods

- (void)didSelectPerson:(ABRecordRef)person identifier:(ABMultiValueIdentifier)identifier
{
    
    // get email
    NSString *emailAddress = @"No Email Address";
    ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
    if (emails)
    {
        if (ABMultiValueGetCount(emails) > 0)
        {
            CFIndex index = 0;
            if (identifier != kABMultiValueInvalidIdentifier)
            {
                index = ABMultiValueGetIndexForIdentifier(emails, identifier);
            }
            emailAddress = CFBridgingRelease(ABMultiValueCopyValueAtIndex(emails, index));
        }
        CFRelease(emails);
    }
    self.savedEmail = emailAddress;
    
    // get phone number
    NSString *phoneNumber = @"No Phone Number";
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (phoneNumbers) {
        if (ABMultiValueGetCount(phoneNumbers) > 0)
        {
            CFIndex index = 0;
            if (identifier != kABMultiValueInvalidIdentifier) {
                
                index = ABMultiValueGetIndexForIdentifier(phoneNumbers, identifier);
            }
            phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, index));
        }
        CFRelease(phoneNumbers);
    }
    
    self.savedPhoneNumber = phoneNumber;
    
    
    // get address
    NSString *address = @"No Address";
    ABMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
    if (addresses) {
        if (ABMultiValueGetCount(addresses) > 0)
        {
            CFIndex index = 0;
            if (identifier != kABMultiValueInvalidIdentifier) {
                
                index = ABMultiValueGetIndexForIdentifier(addresses, identifier);
            }
            address = CFBridgingRelease(ABMultiValueCopyValueAtIndex(addresses, index));
        }
        CFRelease(addresses);
    }
    self.savedAddress = address;
    
    // get photo
    CFDataRef  photo = ABPersonCopyImageData(person);
    UIImage* image = [UIImage imageWithData:(__bridge NSData*)photo];
    if (image) {
        // convert to pffile and save to savedphoto
        PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(image,0.40)];
        self.savedPhoto = imageFile;
    } else {
        
        NSLog(@"No profile pic");
    }


    // get firstname
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    if (!firstName) {
        firstName = @"";
    } else {
    self.savedFirstName = firstName;
    }
    
    // get lastname
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (!lastName) {
        lastName = @"";
    } else {
        self.savedLastName = lastName;
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure you would like to add this employee?" message:[NSString stringWithFormat:@"%@ %@ \n %@ \n %@ \n %@", firstName, lastName, phoneNumber, emailAddress, address] preferredStyle:UIAlertControllerStyleAlert];

                                 [alert addAction:[UIAlertAction actionWithTitle:@"Add Employee" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                     
                                     // now load all these things into an employee object and save it to parse
                                     [[EmployeeController sharedInstance]createEmployeeWithFirstName:firstName LastName:lastName PhoneNumber:phoneNumber EmailAddress:emailAddress Address:address Photo:self.savedPhoto];
                                     
                                     // TODO: this isn't working. the employees are all being saved to parse, but the names show up as null on the cell
                                     [self.tableView reloadData];
                                 }]];
                                 
                                [alert addAction:[UIAlertAction actionWithTitle:@"Nevermind" style:UIAlertActionStyleCancel handler:nil]];
                                 
                                 [self presentViewController:alert animated:YES completion:nil];

                             }];
    
    }





#pragma mark - login delegate methods

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}



- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


// for when the login attempt fails
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// For when the login view is dismissed
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    //[self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - signup delegate methods

- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}



- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    
        [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}



- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}



- (IBAction)refreshButtonTapped:(id)sender {
    
    [self.tableView reloadData];
    
}



#pragma mark - nsnotifications methods

-(void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToNoPhoneNumber:) name:NoPhoneNumberNotificationKey object:nil];

}

-(void)respondToNoPhoneNumber:(NSNotification *)notification {
    
    // send notification to vc to present alert view "this employee does not have a phone number on file"
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"This employee does not have a phone number on file" preferredStyle:UIAlertControllerStyleAlert];
    
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    
            [self presentViewController:alert animated:YES completion:nil];
}


-(void)unregisterForNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name: NoPhoneNumberNotificationKey object:nil];
}

-(void)dealloc {
    
    [self unregisterForNotifications];
}





#pragma mark - mfmessagecompose delegate method

-(void)textButtonTapped:(NSIndexPath*)indexPath {
    Employee *employee = [[EmployeeController sharedInstance].employees objectAtIndex:indexPath.row];
    
    // if the phoneNumber string contains numbers and his more than 7 characters long
    if (employee.phoneNumber.length >= 7 && [employee.phoneNumber rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
    {
        
        
        NSString *strippedPhoneNumber = [[employee.phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        
        NSLog(@"%@", strippedPhoneNumber);
        
        // launch mfmessagecompose
        MFMessageComposeViewController *messageVC = [MFMessageComposeViewController new];
        messageVC.messageComposeDelegate = self;
        messageVC.recipients = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", strippedPhoneNumber], nil];
        
        [self presentViewController:messageVC animated:YES completion:nil];
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"This employee does not have a phone number on file" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}






#pragma mark - email delegate method

-(void)emailButtonTapped:(NSIndexPath*)indexPath {
    Employee *employee = [[EmployeeController sharedInstance].employees objectAtIndex:indexPath.row];
    
    // if the email string contains @
    NSCharacterSet *cset = [NSCharacterSet characterSetWithCharactersInString:@"@"];
    if ([employee.emailAddress rangeOfCharacterFromSet:cset].location != NSNotFound)
    {
        // launch mfmailcompose
        MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
            mailViewController.mailComposeDelegate = self;
            [mailViewController setToRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", employee.emailAddress], nil]];
        
            [self presentViewController:mailViewController animated:YES completion:nil];

        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"This employee does not have an email address on file" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark - message compose delegate method

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - mail compose delegate method 

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
