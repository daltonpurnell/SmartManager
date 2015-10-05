//
//  TaskController.h
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskController : NSObject

+ (TaskController *) sharedInstance;

- (void)createTaskWithName:(NSString *) name
                    dueDate:(NSDate *) dueDate
                   nextStep:(NSString *) nextStep
            nextStepDueDate:(NSDate *) nextStepDueDate
                       note:(NSString *) note
                   priority: (NSString *) priority
                forEmployee: (Employee *)employee
                 completion:(void (^)(BOOL succeeded, Task *task))completion;

- (void)loadTasksFromParseForEmployee:(Employee *)employee completion:(void (^)(NSArray *tasks, NSError *error))completion;

- (void)updateTask:(Task *)task;
- (void)removeTask:(Task *)task;

@end
