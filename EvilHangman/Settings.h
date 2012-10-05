//
//  Settings.h
//  EvilHangman
//
//  Created by Victor Azizi on 10/4/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface Settings : UIViewController {
    UILabel *sliderlabel;
    UILabel *difficultylabel;
    NSUserDefaults * prefs;
}

@property (nonatomic, retain) UILabel *sliderLabel;
@property (nonatomic, retain) UILabel *difficultyLabel;
-(void)sliderChanged:(id)sender;
-(void)difficultyChanged:(id)sender;
@end
