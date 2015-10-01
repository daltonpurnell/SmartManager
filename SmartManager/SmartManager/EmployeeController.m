//
//  EmployeeController.m
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "EmployeeController.h"

@interface EmployeeController ()

@property (nonatomic, strong) NSArray *employees;

@end


@implementation EmployeeController

+ (EmployeeController *) sharedInstance {
    static EmployeeController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EmployeeController new];
        [sharedInstance loadEmployeesFromParse:^(NSError *error) {
            // Nothing
            
            if (error) {
                NSLog(@"Error: %@", error);
            }
        }];
    });
    return sharedInstance;
}
#pragma mark - Create

-(Employee *)createEmployeeWithFirstName:(NSString *) firstName

                                LastName:(NSString *)lastName

                             PhoneNumber:(NSString *) phoneNumber

                            EmailAddress:(NSString *) emailAddress

                                 Address:(NSString *) address


{
    
    Employee *employee = [Employee object];
    
    employee.firstName = firstName;
    employee.lastName = lastName;
    employee.phoneNumber = phoneNumber;
    employee.emailAddress = emailAddress;
    employee.address = address;

    PFUser *user = [PFUser currentUser];
    employee.user = user;
    employee.ACL = [PFACL ACLWithUser:user];
    [employee.ACL setPublicReadAccess:NO];
    
    [employee saveInBackground];
    
    NSMutableArray *mutableEmployees = [NSMutableArray arrayWithArray:self.employees];
    [mutableEmployees insertObject:employee atIndex:0];
    self.employees = mutableEmployees;
    
    return employee;
    
}



#pragma mark - read

-(void)loadEmployeesFromParse:(void (^)(NSError *error))completion {
    
    PFQuery *query = [Employee query];
    PFUser *user = [PFUser currentUser];
    
    if (user) {
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error) {
                
                self.employees = objects;

                completion(nil);
                
            }else{
                
                completion (error);
                
            }
            
        }];
        
    }else {
        NSLog (@"No user logged in");
    }
    NSLog(@"Loading employees from Parse");
}



#pragma mark - update

-(void)updateEmployee:(Employee *) employee {
    
    [employee saveInBackground];
    
}


#pragma mark - delete

-(void) removeEmployee:(Employee *)employee {
    
    NSMutableArray *mutableEmployees = [NSMutableArray arrayWithArray:self.employees];
    self.employees = mutableEmployees;
    [employee deleteInBackground];
    
}



@end
