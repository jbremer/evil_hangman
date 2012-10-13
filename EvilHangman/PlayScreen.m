//
//  PlayScreen.m
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/22/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "PlayScreen.h"

@implementation PlayScreen

static NSString * labels[] = {@"", @"Not a valid character", @"Character already chosen", @"Character not found", @"Good Job!", @"You Won!", @"You Lose!"};
-(void)updateUI {
    CGRect lbl_word_rect = CGRectMake(20, 0, CGRectGetWidth(self.view.bounds), 80);
    UILabel *lbl_word = [[[UILabel alloc] initWithFrame:lbl_word_rect] autorelease];
    [lbl_word setText:dict.userword];
    [lbl_word setFont:[UIFont fontWithName:@"Courier New" size:(int)CGRectGetWidth(self.view.bounds)/dict.userword.length]];
    [self.view addSubview:lbl_word];
    
    UILabel *guesses = [[[UILabel alloc] initWithFrame:CGRectMake(20, 117, CGRectGetWidth(self.view.bounds), 20)] autorelease];
    [guesses setText:[[[NSString alloc] initWithFormat:@"Tries left: %2d", triesleft] autorelease]]; 
    [self.view addSubview:guesses];
    
    UILabel *curscore = [[[UILabel alloc] initWithFrame:CGRectMake(170, 117, CGRectGetWidth(self.view.bounds), 20)] autorelease];
    [curscore setText:[[[NSString alloc] initWithFormat:@"Score: %d", score] autorelease]];
    [self.view addSubview:curscore];
    
    UILabel *information = [[[UILabel alloc] initWithFrame:CGRectMake(20, 90, CGRectGetWidth(self.view.bounds), 20)] autorelease];
    [information setText:[[[NSString alloc] initWithString:labels[action]] autorelease]]; 
    [self.view addSubview:information];
    
}

-(void)insertText:(NSString *)text {
    char ch = [text characterAtIndex:0];
    if (triesleft > 0)
        action = [dict guessLetter:ch];
    
    if (action == 3)
        triesleft--;
    
    if (action == 4)
        score++;
    
    if (triesleft < 1)
        action = 6;
    
    [self updateUI];
    
    if (action == 5) {
        restart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        restart.frame = CGRectMake(20, 150, 100, 40);
        [restart setTitle:@"Continue?" forState:UIControlStateNormal];
        [restart addTarget:self action:@selector(reInit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:restart];
        
        // TODO check if eligible
        entername = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        entername.frame = CGRectMake(170, 150, 120, 40);
        [entername setTitle:@"Enter name" forState:UIControlStateNormal];
        [entername addTarget:self action:@selector(Init) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:entername];
    }
    
    if (action == 6) {
        restart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        restart.frame = CGRectMake(20, 150, 100, 40);
        [restart setTitle:@"Replay?" forState:UIControlStateNormal];
        [restart addTarget:self action:@selector(Init) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:restart];
        
        // TODO check if eligible
        entername = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        entername.frame = CGRectMake(170, 150, 120, 40);
        [entername setTitle:@"Enter name" forState:UIControlStateNormal];
        [entername addTarget:self action:@selector(Init) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:entername];
    }
}

-(void)deleteBackward {
}

-(BOOL)hasText {
    return NO;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)reInit {
    action = 0;
    prefs = [NSUserDefaults standardUserDefaults];
    triesleft = (int)[prefs floatForKey:@"slidervalue"];
    
    if ([prefs boolForKey:@"difficulty"] == 1) {
        dict.difficulty = 2;
    } else {
        dict.difficulty = 0;
    }
    [entername removeFromSuperview];
    [restart removeFromSuperview];    
    [dict initWord];
    [self updateUI];
}

-(void)Init {
    score = 0;
    action = 0;
    prefs = [NSUserDefaults standardUserDefaults]; 
    triesleft = (int)[prefs floatForKey:@"slidervalue"];

    if ([prefs boolForKey:@"difficulty"] == 1) {
        dict.difficulty = 2;
    } else {
        dict.difficulty = 0;
    }
    [entername removeFromSuperview];
    [restart removeFromSuperview];
    [dict initWord];
    [self updateUI];
}
         
         
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        dict = [[Dictionary alloc] init];
        [self Init];
    }
    return self;
}

- (void)dealloc {
    [dict release];
    [super dealloc];
}
@end
