//
//  CustomExpandingCell.h
//  SmartManager
//
//  Created by Dalton on 7/28/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTaskCell.h"
#import "EmployeeController.h"
#import "MainTableViewController.h"

@protocol textButtonTappedDelegate;
@protocol emailButtonTappedDelegate;


@interface CustomExpandingCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) id <textButtonTappedDelegate>delegate;
@property (nonatomic, strong) id <emailButtonTappedDelegate>emailDelegate;


@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *textButton;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (nonatomic, strong) Employee *employee;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end



@protocol textButtonTappedDelegate <NSObject>

- (IBAction)textButtonTapped:(NSIndexPath *)indexPath;

@end



@protocol emailButtonTappedDelegate <NSObject>

- (IBAction)emailButtonTapped:(NSIndexPath *)indexPath;

@end
