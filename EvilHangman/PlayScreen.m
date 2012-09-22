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
    char show_word[32] = {0};

    for (int i = 0; i < word.length; i++) {
        char ch = [word characterAtIndex:i];
        show_word[i] = letters[ch - 'a'] ? ch : '*';
    }

    CGRect lbl_word_rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40);
    UILabel *lbl_word = [[[UILabel alloc] initWithFrame:lbl_word_rect] autorelease];
    [lbl_word setText:[NSString stringWithCString:show_word encoding:NSUTF8StringEncoding]];
    [lbl_word setFont:[UIFont fontWithName:@"Courier New" size:(int)CGRectGetWidth(self.view.bounds)/wordlen]];
    [self.view addSubview:lbl_word];
}

-(void)insertText:(NSString *)text {
    char ch = [text characterAtIndex:0];
    if(ch >= 'a' && ch <= 'z') {
        letters[ch - 'a'] = 1;
        [self showWord];
    }
}

-(void)deleteBackward {
}

-(BOOL)hasText {
    return NO;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        word = @"hangman";
        wordlen = 7;

        memset(letters, 0, sizeof(letters));

        [self showWord];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    // pop a keyboard
    [self becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
