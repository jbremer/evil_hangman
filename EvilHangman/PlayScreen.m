//
//  PlayScreen.m
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/22/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "PlayScreen.h"
#import "HighScoreScreen.h"

@implementation PlayScreen

static NSString * labels[] = {@"", @"Not a valid character", @"Character already chosen", @"Character not found", @"Good Job!", @"You Won!", @"You Lose!", @"Enter your name"};

- (void) updateUI {
    if (!firsttime) {
        [lbl_word removeFromSuperview];
        [guesses removeFromSuperview];
        [scorecounter removeFromSuperview];
        [information removeFromSuperview];
    } firsttime = false;
    
    if (action == 7) {
        
        lbl_word_rect = CGRectMake(20, 0, CGRectGetWidth(self.view.bounds), 80);
        lbl_word = [[[UILabel alloc] initWithFrame:lbl_word_rect] autorelease];
        [lbl_word setText:username];
        [lbl_word setFont:[UIFont fontWithName:@"Courier New" size:(int)CGRectGetWidth(self.view.bounds)/16]];
        [self.view addSubview:lbl_word];
    
    } else {
        lbl_word_rect = CGRectMake(20, 0, CGRectGetWidth(self.view.bounds), 80);
        lbl_word = [[[UILabel alloc] initWithFrame:lbl_word_rect] autorelease];
        [lbl_word setText:dict.userword];
        [lbl_word setFont:[UIFont fontWithName:@"Courier New" size:(int)CGRectGetWidth(self.view.bounds)/dict.userword.length]];
        [self.view addSubview:lbl_word];
    }
    
    guesses = [[[UILabel alloc] initWithFrame:CGRectMake(20, 117, CGRectGetWidth(self.view.bounds), 20)] autorelease];
    [guesses setText:[[[NSString alloc] initWithFormat:@"Tries left: %2d", triesleft] autorelease]];
    [self.view addSubview:guesses];
    
    scorecounter = [[[UILabel alloc] initWithFrame:CGRectMake(170, 117, CGRectGetWidth(self.view.bounds), 20)] autorelease];
    [scorecounter setText:[[[NSString alloc] initWithFormat:@"Score: %d", curscore] autorelease]];
    [self.view addSubview:scorecounter];
    
    information = [[[UILabel alloc] initWithFrame:CGRectMake(20, 90, CGRectGetWidth(self.view.bounds), 20)] autorelease];
    [information setText:[[[NSString alloc] initWithString:labels[action]] autorelease]];
    [self.view addSubview:information];
}

- (void) insertText: (NSString *) text {
    
    if (action == 7) {
        if ([username length] < 16) {
            [username appendString:text];
            [self updateUI];
        }
        
    } else {
        char ch = [text characterAtIndex:0];

        if (triesleft > 0 && [dict.userword rangeOfString:@"*"].location != NSNotFound)
            action = [dict guessLetter:ch];
        else return;
    
        if (action == 3)
            triesleft--;
    
        if (action == 4)
            curscore++;
    
        if (triesleft < 1)
            action = 6;
    
        if (action == 5)
            curscore++;
    
        [self updateUI];
    
        if (action == 5) {
            button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button1.frame = CGRectMake(20, 150, 100, 40);
            [button1 setTitle:@"Continue" forState:UIControlStateNormal];
            [button1 addTarget:self action:@selector(newword) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button1];
        
            if ([self eligible : curscore]) {
                waseligible = true;
                button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button2.frame = CGRectMake(170, 150, 120, 40);
                [button2 setTitle:@"Enter name" forState:UIControlStateNormal];
                [button2 addTarget:self action:@selector(getname) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button2];
            }
        }
    
        if (action == 6) {
            button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button1.frame = CGRectMake(20, 150, 100, 40);
            [button1 setTitle:@"New Game" forState:UIControlStateNormal];
            [button1 addTarget:self action:@selector(newgame) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button1];
        
            // TODO check if eligible
            if ([self eligible : curscore]) {
                waseligible = true;
                button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button2.frame = CGRectMake(170, 150, 120, 40);
                [button2 setTitle:@"Enter name" forState:UIControlStateNormal];
                [button2 addTarget:self action:@selector(getname) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button2];
            }
        }
    }
}

- (void) deleteBackward {
    if (action == 7 && [username length] != 0) {
        [username setString:[username substringToIndex:[username length]-1]];
        [self updateUI];
    }
}

- (BOOL) hasText {
    return NO;
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) Init {
    firsttime = true;
    prefs = [NSUserDefaults standardUserDefaults]; 

    if ([prefs boolForKey:@"difficulty"] == 1)
        dict.difficulty = 2;
    else
        dict.difficulty = 0;

    [self newgame];
}

- (void) newgame {
    curscore = 0;
    [self newword];
}

- (void) newword {
    [button1 removeFromSuperview];
    if (action != 7 && waseligible)
        [button2 removeFromSuperview];
    waseligible = false;

    action = 0;
    triesleft = MAX((int)[prefs floatForKey:@"slidervalue"],4);
    [dict initWord];
    
    [self updateUI];
}
         
- (id) initWithNibName: (NSString *) nibNameOrNil bundle : (NSBundle *) nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        dict = [[Dictionary alloc] init];
        [self Init];
    }
    return self;
}

- (void) dealloc {
    [dict release];
    [super dealloc];
}

- (void) getname {
    [button1 removeFromSuperview];
    [button2 removeFromSuperview];
    action = 7;
    username = [[NSMutableString alloc] init];
    
    button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(20, 150, 100, 40);
    [button1 setTitle:@"Done" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(addcurname) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    [self updateUI];
}

- (void) addcurname {
    if ([username length] > 0) {
        [self add : username, curscore];
        [self newgame];
    }
}

- (bool) add : (NSString *) name, int score {
    if ([name rangeOfString:@"\n"].location != NSNotFound &&
        [name rangeOfString:@"\t"].location != NSNotFound)
        return false;
    
    NSString *oldscore = [prefs objectForKey:@"scores"];
    NSMutableString *newscore = [@"" mutableCopy];
    NSCharacterSet *tabsnenters = [NSCharacterSet characterSetWithCharactersInString:@"\n\t"];
    NSArray * strings = [oldscore componentsSeparatedByCharactersInSet: tabsnenters];
    
    int added = 0;
    for (int i = 0; i+added < 10; i++) {
        // if old score length has not been reached
        if (i*2+1 < [strings count]) {
            // if score in args not added yet and is higher than score at current index: add arg and current value if new scorelist is not full
            if (added == 0 && score > [[strings objectAtIndex:i*2+1] intValue]) {
                [newscore appendString:name];
                [newscore appendString:@"\t"];
                [newscore appendString:[NSString stringWithFormat:@"%d",score]];
                [newscore appendString:@"\n"];
                added = 1;
                if (i+added < 9) {
                    [newscore appendString:[strings objectAtIndex:i*2]];
                    [newscore appendString:@"\t"];
                    [newscore appendString:[strings objectAtIndex:i*2+1]];
                    [newscore appendString:@"\n"];
                }
                // otherwise add score at next index
            } else {
                [newscore appendString:[strings objectAtIndex:i*2]];
                [newscore appendString:@"\t"];
                [newscore appendString:[strings objectAtIndex:i*2+1]];
                [newscore appendString:@"\n"];
            }
            // if all scores have been looped through but the score given with the arg has not been added yet: add
        } else if (added == 0 && score > 0) {
            [newscore appendString:name];
            [newscore appendString:@"\t"];
            [newscore appendString:[NSString stringWithFormat:@"%d",score]];
            [newscore appendString:@"\n"];
            added = 1;
            break;
        } else break;
    }
    
    if (added == 1) {
        [prefs setObject: newscore forKey:@"scores"];
        return true;
    } else return false;
}

- (bool) eligible : (int) score {
    if (score < 1)
        return false;
    
    NSString *oldscore = [prefs objectForKey:@"scores"];
    NSCharacterSet *tabsnenters = [NSCharacterSet characterSetWithCharactersInString:@"\n\t"];
    NSArray * strings = [oldscore componentsSeparatedByCharactersInSet: tabsnenters];
    
    if ([strings count] < 21) return true;
    else if ([[strings objectAtIndex:19] intValue] < score) return true;
    else return false;
}

@end
