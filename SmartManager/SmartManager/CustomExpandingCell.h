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
@import Parse;
@import ParseUI;

@protocol textButtonTappedDelegate;
@protocol emailButtonTappedDelegate;
@protocol addTaskButtonTappedDelegate;


@interface CustomExpandingCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) id <textButtonTappedDelegate>delegate;
@property (nonatomic, strong) id <emailButtonTappedDelegate>emailDelegate;
@property (nonatomic, strong) id <addTaskButtonTappedDelegate>addTaskDelegate;


@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *textButton;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (weak, nonatomic) IBOutlet PFImageView *photo;
@property (nonatomic, strong) NSArray *tasks;

@property (nonatomic, strong) Employee *employee;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end



@protocol textButtonTappedDelegate <NSObject>

- (IBAction)textButtonTapped:(NSIndexPath *)indexPath;

@end



@protocol emailButtonTappedDelegate <NSObject>

- (IBAction)emailButtonTapped:(NSIndexPath *)indexPath;

@end



@protocol addTaskButtonTappedDelegate <NSObject>

- (IBAction)addTaskButtonTapped:(NSIndexPath *)indexPath;

@end
