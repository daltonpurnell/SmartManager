//
//  CustomTaskCell.m
//  SmartManager
//
//  Created by Dalton on 7/28/15.
//  Copyright (c) 2015 Dalton. All rights reserved.
//

#import "CustomTaskCell.h"
#import "Appearance.h"

@implementation CustomTaskCell

- (void)awakeFromNib {
    // Initialization code
    
    [Appearance initializeAppearanceDefaults];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)checkBoxTapped:(id)sender {
}
- (IBAction)taskDueDateTapped:(id)sender {
}
- (IBAction)nextStepDueDateTapped:(id)sender {
}
- (IBAction)editButtonTapped:(id)sender {
}





@end
