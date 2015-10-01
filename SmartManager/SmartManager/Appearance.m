//
//  Appearance.m
//  SmartManager
//
//  Created by Dalton on 10/1/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "Appearance.h"

@implementation Appearance


+ (void) initializeAppearanceDefaults {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:80/255.0 green:157/255.0 blue:64/255.0 alpha:1]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:80/255.0 green:157/255.0 blue:64/255.0 alpha:1]];
    
    [[UIToolbar appearance] setBarTintColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1]];
    
    [[UIToolbar appearance] setTintColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    
    [[UILabel appearance] setTextColor:[UIColor colorWithRed:74/255.0 green:75/255.0 blue:76/255.0 alpha:1]];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:122/255.0 green:197/255.0 blue:237/255.0 alpha:1],
                                                           NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"SystemFont" size: 22.0],
                                                           NSFontAttributeName,
                                                           nil]];

    
}
@end
