//
//  HighScoreScreen.h
//  EvilHangman
//
//  Created by Kas van 't Veer on 9/28/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Scores : NSObject {
    int scores[10];
    
    char names[10][17];
}
@end

@interface HighScoreScreen : UIViewController
- (Scores *)loadScores;
- (void)saveScores:(Scores *)obj;
- (id)init;
@end