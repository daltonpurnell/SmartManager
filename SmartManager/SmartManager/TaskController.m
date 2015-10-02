//
//  TaskController.m
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "TaskController.h"

@implementation TaskController


+ (TaskController *) sharedInstance {
    static TaskController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [TaskController new];
    });
    return sharedInstance;
}


#pragma mark - Create

- (void) createTaskWithName:(NSString *)name
                     dueDate:(NSDate *)dueDate
                    nextStep:(NSString *)nextStep
             nextStepDueDate:(NSDate *)nextStepDueDate
                        note:(NSString *)note
                    priority:(NSNumber *)priority
                 forEmployee:(Employee *)employee completion:(void (^)(BOOL, Task *))completion {
    
    Task *task = [Task object];
    
    task.name = name;
    task.dueDate = dueDate;
    task.nextStep = nextStep;
    task.nextStepDueDate = nextStepDueDate;
    task.note = note;
    task.employee = employee;
    
    PFUser *user = [PFUser currentUser];
    task.user = user;
    task.ACL = [PFACL ACLWithUser:user];
    [task saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completion(succeeded, task);
    }];
    
}



#pragma mark - Read

- (void)loadTasksFromParseForEmployee:(Employee *)employee completion:(void (^)(NSArray *, NSError *))completion {
    
    NSLog(@"Loading tasks from Parse");
    PFQuery *query = [Task query];
    
    [query whereKey:@"Employee" equalTo:employee];
    
    // [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            completion(objects, nil);
        } else {
            completion(nil, error);
        }
    }];
    
}

#pragma mark - Update

- (void)updateTask:(Task *)task {
    
    //    [entry pinInBackground];
    [task saveInBackground];
    
}

#pragma mark - Delete

- (void)removeTask:(Task *)task {
    [task deleteInBackground];
}


@end
