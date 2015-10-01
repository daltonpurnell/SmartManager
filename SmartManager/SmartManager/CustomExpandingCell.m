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
    
    self.tasksTableView.delegate = self;
    self.tasksTableView.dataSource = self;
    
    [Appearance initializeAppearanceDefaults];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.employee.firstName, self.employee.lastName];

}

#pragma mark - tasks table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
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
}
- (IBAction)emailButtonTapped:(id)sender {
}
- (IBAction)textButtonTapped:(id)sender {
}
- (IBAction)addTaskButtonTapped:(id)sender {
}



@end
