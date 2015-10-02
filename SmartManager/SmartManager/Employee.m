//
//  Employee.m
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "Employee.h"

static NSString * const EmployeeClassName = @"Employee";


@implementation Employee

@dynamic firstName;
@dynamic lastName;
@dynamic phoneNumber;
@dynamic emailAddress;
@dynamic address;
@dynamic user;
@dynamic task;
@dynamic photo;

+ (NSString *)parseClassName {
    return EmployeeClassName;
}

@end
