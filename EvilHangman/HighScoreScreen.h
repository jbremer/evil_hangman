//
//  HighScoreScreen.h
//  EvilHangman
//
//  Created by Kas van 't Veer on 9/28/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreScreen : UIViewController {
    CGRect screenRect;
    CGFloat screenWidth;
    NSUserDefaults *prefs;
    UILabel *title;
    UIButton * button;
    UILabel * playerlist;
}
@end