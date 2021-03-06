//
//  PlayScreen.h
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/22/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dictionary.h"

@interface PlayScreen : UIViewController <UIKeyInput> {
    Dictionary *dict;
    NSUserDefaults *prefs;
    CGRect lbl_word_rect;
    UILabel *lbl_word;
    UILabel *information;
    UILabel *guesses;
    UILabel *scorecounter;
    UIButton * button1;
    UIButton * button2;
    bool waseligible;
    bool firsttime;

    int triesleft;
    int curscore;
    
    NSMutableString* username;
    
    // Action is the output of [dict guessletter]
    // 1 -> not a valid char
    // 2 -> char already guessed
    // 3 -> char not found
    // 4 -> char found
    // 5 -> word guessed
    int action;
}
-(void) Init;

@end
