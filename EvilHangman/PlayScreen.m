//
//  PlayScreen.m
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/22/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "PlayScreen.h"

@implementation PlayScreen

-(void)showWord {
    CGRect lbl_word_rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 80);
    UILabel *lbl_word = [[[UILabel alloc] initWithFrame:lbl_word_rect] autorelease];
    [lbl_word setText:dict.userword];
    [lbl_word setFont:[UIFont fontWithName:@"Courier New" size:(int)CGRectGetWidth(self.view.bounds)/dict.userword.length]];
    [self.view addSubview:lbl_word];
}

-(void)insertText:(NSString *)text {
    char ch = [text characterAtIndex:0];
    bool found = [dict guessLetter:ch];
    [self showWord];

    // TODO: do something with "found"
}

-(void)deleteBackward {
}

-(BOOL)hasText {
    return NO;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        dict = [[Dictionary alloc] init];

        [dict initWord];
        [self showWord];
    }
    return self;
}

@end
