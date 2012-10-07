//
//  HighScoreScreen.m
//  EvilHangman
//
//  Created by Kas van 't Veer on 9/28/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "HighScoreScreen.h"

@implementation Scores
@end

@implementation HighScoreScreen
	
- (void)saveScores:(Scores *)obj {
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:@"highscore"];
}

- (Scores *)loadScores{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:@"highscore"];
    Scores *obj = (Scores *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return obj;
}

- (id)init {
    self = [super init];
    if (self) {
        NSLog(@"sup");
        Scores *data = [[Scores alloc] init];
        data = [self loadScores];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
        title.text = @"Highscore";
        title.textAlignment = UITextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:25];
        
        UILabel *playerlist = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 500)];
        playerlist.numberOfLines = 0;
        playerlist.textAlignment = UITextAlignmentCenter;
        /*NSMutableString *derp;
        
        for (int i = 0; i < [data count]; i++) {
           [derp appendString: [NSString stringWithFormat:@"%@\t %i",[[data objectAtIndex:i] name],[[data objectAtIndex:i] score]]];
        }
        
        [playerlist setText : derp];
        
        [self.view addSubview:playerlist];*/
        [self.view addSubview:title];
    }
    return self;
}

@end