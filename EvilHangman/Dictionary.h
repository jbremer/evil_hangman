//
//  Dictionary.h
//  EvilHangman
//
//  Created by Victor Azizi on 9/23/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pthread.h>

//Pthread that bitch n make some nice dict without lag yes? (This happens in the 
//Initializer)
@interface Dictionary : NSObject
{
    /*Contains the word that should be printed, Has _ instead of letter
     When the letter is not yet guessed. */
    char userword[100];
    
    /* The difficulty is used to distinguish between 3 modes,
     Namely Evil (2), Semi-evil (1) and honest (0). Default = 1*/
    int difficulty;
    
    //Null terminated string with already guessed letters
    char guessedletters[27];
    
    @private
    NSMutableArray * dict;
   
    @private
    NSMutableArray * possiblewords;
    
    @private 
   // NSString * ourword;
} 

//Initializes the word to a certain length, empties already guessed letters
- (void)initWord;


//gues a letter! Returns true if the word is guessed
- (bool)guessLetter:(char)letter;

@end
