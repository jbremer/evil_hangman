//
//  PlayScreen.m
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/22/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "PlayScreen.h"

@implementation PlayScreen

static NSString * labels[] = {@"", @"Not a valid character", @"Character already chosen", @"Character not found", @"Good Job!", @"You Won!"};
-(void)updateUI {
    CGRect lbl_word_rect = CGRectMake(20, 20, CGRectGetWidth(self.view.bounds), 60);
    UILabel *lbl_word = [[[UILabel alloc] initWithFrame:lbl_word_rect] autorelease];
    [lbl_word setText:dict.userword];
    [lbl_word setFont:[UIFont fontWithName:@"Courier New" size:(int)CGRectGetWidth(self.view.bounds)/dict.userword.length]];
    [self.view addSubview:lbl_word];
    
    UILabel *guesses = [[[UILabel alloc] initWithFrame:CGRectMake(20, 60, CGRectGetWidth(self.view.bounds), 80)] autorelease];
    [guesses setText:[[[NSString alloc] initWithFormat:@"Tries left: %2d", triesleft] autorelease]]; 
    [self.view addSubview:guesses];
    
    UILabel *information = [[[UILabel alloc] initWithFrame:CGRectMake(20, 140, CGRectGetWidth(self.view.bounds), 40)] autorelease];
    [information setText:[[[NSString alloc] initWithString:labels[action]] autorelease]]; 
    [self.view addSubview:information];
    
}

-(void)insertText:(NSString *)text {
    char ch = [text characterAtIndex:0];
    action = [dict guessLetter:ch];
    if (action == 3)
        triesleft--;
    
    [self updateUI];
}

-(void)deleteBackward {
}

-(BOOL)hasText {
    return NO;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        prefs = [NSUserDefaults standardUserDefaults]; 
        triesleft = (int)[prefs floatForKey:@"slidervalue"];
        dict = [[Dictionary alloc] init];

        [dict initWord];
        [self updateUI];
    }
    return self;
}

@end
