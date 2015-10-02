//
//  EmployeeController.h
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@interface EmployeeController : NSObject
@property (strong, nonatomic, readonly) NSArray *employees;


+ (EmployeeController *) sharedInstance;

-(Employee *)createEmployeeWithFirstName:(NSString *) firstName

                                LastName:(NSString *)lastName

                             PhoneNumber:(NSString *) phoneNumber

                            EmailAddress:(NSString *) emailAddress

                                 Address:(NSString *) address

                                   Photo:(PFFile *) photo;

-(void)loadEmployeesFromParse:(void (^)(NSError *error))completion;

-(void)updateEmployee:(Employee *)employee;

-(void) removeEmployee:(Employee *) employee;

@end
