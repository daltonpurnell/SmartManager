//
//  Employee.h
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@import Parse;

@class Task;

@interface Employee : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) PFFile *photo;

@property (nonatomic, strong) Task *task;

+ (NSString *)parseClassName;

@end
