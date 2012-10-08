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
        [self faggotry];
        prefs = [NSUserDefaults standardUserDefaults];
        NSString *Score = [[NSString alloc] initWithString:[prefs stringForKey:@"scores"]];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
        title.text = @"Highscore";
        title.textAlignment = UITextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:25];
        
        UILabel *playerlist = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 500)];
        playerlist.numberOfLines = 0;
        playerlist.textAlignment = UITextAlignmentCenter;
        
        [playerlist setText : Score];
        
        [self.view addSubview:playerlist];
        [self.view addSubview:title];
    }
    return self;
}

- (void)faggotry{
    NSString *durr = [[NSString alloc] initWithString:@"Henk\t12"];
    [prefs setString: durr forKey:@"scores"];
}

@end