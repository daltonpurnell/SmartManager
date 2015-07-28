//
//  CustomExpandingCell.m
//  SmartManager
//
//  Created by Dalton on 7/28/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomExpandingCell.h"

@implementation CustomExpandingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    self.tasksTableView.delegate = self;
    self.tasksTableView.dataSource = self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}


- (CustomTaskCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTaskCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return customCell;
}

#pragma mark - events
- (IBAction)callButtonTapped:(id)sender {
}
- (IBAction)emailButtonTapped:(id)sender {
}
- (IBAction)textButtonTapped:(id)sender {
}



@end
