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
        [self addraw];
        [self add:@"Hanz",300];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *Score = [prefs objectForKey:@"scores"];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
        title.text = @"Highscore";
        title.textAlignment = UITextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:25];
        
        UILabel *playerlist = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 80)];
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
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    NSString *oldscore = [prefs objectForKey:@"scores"];
    NSMutableString *newscore = [oldscore mutableCopy];
    NSCharacterSet *tabsnenters = [NSCharacterSet characterSetWithCharactersInString:@"\n\t"];
    NSArray * strings = [oldscore componentsSeparatedByCharactersInSet: tabsnenters];
    int added = 0;
    for (int i = 0; i+added < 10; i++) {
        // if old score length has not been reached
        if (i*2+1 < [strings count]) {
            // if score in args not added yet and is higher than score at current index: add arg and current value if new scorelist is not full
            if (added == 0 && score > (int)[strings objectAtIndex:i*2+1]) {
                [newscore appendString:name];
                [newscore appendString:@"\t"];
                [newscore appendString:(NSString *)score];
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
        } else if (added == 0 && (int)[strings objectAtIndex:i*2+1] != 0) {
            [newscore appendString:name];
            [newscore appendString:@"\t"];
            [newscore appendString:(NSString *)score];
            [newscore appendString:@"\n"];
            added = 1;
            break;
        }
        
    }
    if (added == 0) {
        [prefs setObject: newscore forKey:@"scores"];
        return true;
    } else return false;
}

- (void) addraw {
    NSUserDefaults * prefs = [NSUserDefaults standardUserDefaults];
    NSString *scorez = @"Henk\t1337\nHerp\t500\nDerp\t100";
    [prefs setObject: scorez forKey:@"scores"];
}

@end