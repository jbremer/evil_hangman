//
//  Dictionary.h
//  EvilHangman
//
//  Created by Victor Azizi on 9/23/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pthread.h>

@interface Dictionary : NSObject
{
    /*Contains the word that should be printed, Has _ instead of letter
     When the letter is not yet guessed. Default = hangman*/
    NSString * word;
    
    /* The difficulty is used to distinguish between 3 modes,
     Namely Evil (2), Semi-evil (1) and honest (0). Default = 2*/
    int difficulty;
    
    int guessedletters;
} 

//Pthread that bitch n make some nice dict without lag yes?
void Dictionary();

//Initializes the word to a certain length, empties already guessed letters
NSString * initWord(int length);

//gues a letter! Returns true if the word is guessed
bool guessLetter(char letter);

@end
