//
//  Settings.m
//  EvilHangman
//
//  Created by Victor Azizi on 10/4/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize sliderLabel;
@synthesize difficultyLabel;

-(void) sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.sliderLabel.text=[[[NSString alloc] initWithFormat:@"%d", (int)(slider.value + 0.5f)] autorelease];
    [prefs setFloat:slider.value forKey:@"slidervalue"];
}
-(void) difficultyChanged:(id)sender {
    UISwitch *Switch = (UISwitch *)sender;
    [prefs setBool:Switch.on forKey:@"difficulty"];
}

-(void) buildUI {
    //Get User Preferences
    prefs = [NSUserDefaults standardUserDefaults];
    
    //Build le UI
    UILabel *desc = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 180, 40)] autorelease];
    UILabel *desc2 = [[[UILabel alloc] initWithFrame:CGRectMake(20, 140, 120, 20)] autorelease];
    desc.text = [[[NSString alloc] initWithFormat:@"Number of Guesses:"] autorelease];
    desc2.text = [[[NSString alloc] initWithFormat:@"Evil mode:"] autorelease];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 40, 250, 40)];
    slider.maximumValue=26;
    slider.minimumValue=4;
    [slider setValue:[prefs floatForKey:@"slidervalue"]];
   
    //Initialize difficulty
    UISwitch * difficulty = [[[UISwitch alloc] initWithFrame:CGRectMake(140, 140, 40, 40)] autorelease];
    [difficulty addTarget:self action:@selector(difficultyChanged:) forControlEvents:UIControlEventValueChanged];
    [difficulty setOn:[prefs boolForKey:@"difficulty"]];
    [self difficultyChanged:difficulty];
    
    //Bind le sliderlabel to le slider
    self.sliderLabel = [[[UILabel alloc] initWithFrame:CGRectMake(200, 0, 20, 40)] autorelease];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self sliderChanged:slider];
        
    [self.view addSubview:desc];
    [self.view addSubview:desc2];
    [self.view addSubview:self.sliderLabel];
    [self.view addSubview:slider];
    [self.view addSubview:difficulty];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self buildUI];
    }
    return self;
}
- (void)dealloc {
    [sliderLabel release];
    [super dealloc];
}
@end
