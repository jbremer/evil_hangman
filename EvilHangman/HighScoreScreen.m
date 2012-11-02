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
        //test, delete this line for normal functionality
        
        prefs = [NSUserDefaults standardUserDefaults];
        
        screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
        title.text = @"Highscore";
        title.textAlignment = UITextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:25];
        
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(20, 350, 150, 40);
        [button setTitle:@"Reset Highscore" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:title];
        [self.view addSubview:button];
        [self updateScores];

    }
    return self;
}

- (void) updateScores {
    NSString *Score = [prefs objectForKey:@"scores"];
    playerlist = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 300)];
    playerlist.numberOfLines = 0;
    playerlist.textAlignment = UITextAlignmentCenter;
    [playerlist setText : Score];
    [self.view addSubview:playerlist];

}

- (void) reset {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Reset highscore?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [prefs setObject: @"" forKey:@"scores"];
        [playerlist removeFromSuperview];
        [self updateScores];
    }
}

@end