//
//  CustomExpandingCell.m
//  SmartManager
//
//  Created by Dalton on 7/28/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomExpandingCell.h"
#import "Appearance.h"

@implementation CustomExpandingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    self.photo.layer.borderWidth = 1.5f;
    self.photo.layer.borderColor = [UIColor colorWithRed:80/255.0 green:157/255.0 blue:64/255.0 alpha:0.75].CGColor;
    self.photo.layer.masksToBounds = NO;
    self.photo.clipsToBounds = YES;
    self.photo.layer.cornerRadius = 21.5;
    
    
    
    self.tasksTableView.delegate = self;
    self.tasksTableView.dataSource = self;
    
    [Appearance initializeAppearanceDefaults];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.employee.firstName, self.employee.lastName];
    
    // if there's a file stored for the employee, load it into the image view
    if (self.photo.file) {
        self.photo.file = self.employee.photo;
    }
    
//    [[TaskController sharedInstance]loadTasksFromParseForEmployee:self.employee completion:^(NSArray *tasks, NSError *error) {
//
//    tasks = self.tasks
//    NSLog(@"Tasks loaded from Parse");
//    }];
    
}




#pragma mark - tasks table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.tasks.count;
}


- (CustomTaskCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTaskCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return customCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}




// set up priority labels for section headers
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *v =[[UIView alloc] init];
    
    v.backgroundColor = [UIColor clearColor];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width - 10, 18)];
    
    label.textColor = [UIColor  darkGrayColor];
    
    label.font = [UIFont boldSystemFontOfSize:15];
    
    label.backgroundColor = [UIColor clearColor];
    
    if (section  == 0) {
        
        label.text = @"Priority 1";
        
        [v addSubview:label];
    }
    else if (section == 1) {
        
        label.text = @"Priority 2";
        
        [v addSubview:label];
        
    }
    else if (section == 2) {
        
        label.text = @"Priority 3";
        
        [v addSubview:label];
        
    }
    
    return v;
    
}




#pragma mark - events
- (IBAction)callButtonTapped:(id)sender {
    
    // if the phoneNumber string contains numbers and his more than 7 characters long
    if (self.employee.phoneNumber.length >= 7 && [self.employee.phoneNumber rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
    {
        
        NSString *strippedPhoneNumber = [[self.employee.phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        
        NSLog(@"%@", strippedPhoneNumber);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", strippedPhoneNumber]]];
    } else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NoPhoneNumberNotificationKey object:nil userInfo:nil];
    }
}


- (IBAction)addTaskButtonTapped:(id)sender {
    
    // this is done in storyboard
    [self.addTaskDelegate addTaskButtonTapped:self.indexPath];

}



# pragma mark - email and text delegate methods

- (IBAction)emailButtonTapped:(id)sender {
    
    [self.emailDelegate emailButtonTapped:self.indexPath];
    
}



- (IBAction)textButtonTapped:(id)sender {
    
    [self.delegate textButtonTapped:self.indexPath];
    
}





@end
