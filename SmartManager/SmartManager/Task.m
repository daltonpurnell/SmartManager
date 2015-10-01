//
//  Task.m
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "Task.h"

static NSString * const TaskClassName = @"Task";


@implementation Task

@dynamic employee;
@dynamic user;
@dynamic name;
@dynamic dueDate;
@dynamic nextStep;
@dynamic nextStepDueDate;
@dynamic note;
@dynamic priority;

+ (NSString *)parseClassName {
    return TaskClassName;
}


@end
