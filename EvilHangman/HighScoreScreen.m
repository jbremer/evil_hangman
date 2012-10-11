//
//  HighScoreScreen.m
//  EvilHangman
//
//  Created by Kas van 't Veer on 9/28/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "HighScoreScreen.h"

@implementation HighScoreScreen

- (id)init {
    self = [super init];
    if (self) {
        [self unittest:@"Henkie" , 42];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *Score = [prefs objectForKey:@"scores"];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
        title.text = @"Highscore";
        title.textAlignment = UITextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:25];
        
        UILabel *playerlist = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 300)];
        playerlist.numberOfLines = 0;
        playerlist.textAlignment = UITextAlignmentCenter;
        
        [playerlist setText : Score];
        
        [self.view addSubview:playerlist];
        [self.view addSubview:title];
    }
    return self;
}


// Saving some random stuff to NSUserdefaults
- (bool) add : (NSString *)name, int score {
    if ([name rangeOfString:@"\n"].location != NSNotFound &&
        [name rangeOfString:@"\t"].location != NSNotFound)
        return false;
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
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
        } else if (added == 0 && score != 0) {
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

// Test the bunch by adding ten dummyplayers to the highscore and adding an eleventh with chosen name and score
- (void) unittest : (NSString *) name, int score {
    [self fillwithdummies];
    if ([self eligible: score])
        [self add: name, score];
    
}

// Saving some random stuff to NSUserdefaults
- (bool) eligible : (int) score {
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    NSString *oldscore = [prefs objectForKey:@"scores"];
    NSCharacterSet *tabsnenters = [NSCharacterSet characterSetWithCharactersInString:@"\n\t"];
    NSArray * strings = [oldscore componentsSeparatedByCharactersInSet: tabsnenters];
    if ([strings count] < 21)
        return true;
    else if ([[strings objectAtIndex:19] intValue] < score)
        return true;
    else
        return false;
}

// Fill the scores key in nsuserdefaults for testing purposes
- (void) fillwithdummies {
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    NSString *scorez = @"one\t100\ntwo\t90\nthree\t80\nfour\t70\nfive\t60\nsix\t50\nseven\t40\neight\t30\nnine\t20\nten\t10\n";
    [prefs setObject: scorez forKey:@"scores"];
}

@end