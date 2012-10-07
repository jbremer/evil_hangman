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
        [self faggotry];
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


// random assignment to test methods
// tofix: bad excess crap..
-(void)faggotry{
    Scores *herp = [[Scores alloc] init];
    herp = [self loadScores];
    herp->points[0] = 1337;
    herp->points[1] = 9001;
    herp->points[2] = 1234;
    herp->points[3] = 911;
    herp->points[4] = 420;
    herp->points[5] = 1234;
    herp->points[6] = 4321;
    herp->points[7] = 42;
    herp->points[8] = 314159;
    herp->points[9] = 271828;

    herp->names[0] = @"Sup";
    herp->names[1] = @"Supzors";
    herp->names[2] = @"hai";
    herp->names[3] = @"test";
    herp->names[4] = @"aaa";
    herp->names[5] = @"derp";
    herp->names[6] = @"herp";
    herp->names[7] = @"nerp";
    herp->names[8] = @"Henk";
    herp->names[9] = @"Henkeh";
    
    [self saveScores:herp];

}

@end