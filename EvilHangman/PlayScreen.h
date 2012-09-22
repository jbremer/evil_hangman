//
//  PlayScreen.h
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/22/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayScreen : UIViewController <UIKeyInput> {
    NSString *word; // temporary
    int wordlen;

    char letters[26]; // contains used letters
}

@end
