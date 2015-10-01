//
//  Task.h
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import <Parse/Parse.h>
#import "Employee.h"

@class Employee;

@interface Task : PFObject <PFSubclassing> 

@property (strong, nonatomic) Employee *employee;
@property (strong, nonatomic) PFUser *user;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSString *nextStep;
@property (strong, nonatomic) NSDate *nextStepDueDate;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSNumber *priority;

+ (NSString *)parseClassName;


@end
