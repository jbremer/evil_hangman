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
@interface Dictionary : NSObject {
    // The difficulty is used to distinguish between 3 modes,
    // 0 -> Honest
    // 1 -> Semi-evil
    // 2 -> Evil
    // By default the mode is set to 1
    int difficulty;
    
    //Null terminated string with already guessed letters
    char guessedletters[26];
    
    NSArray *dict;
   
    NSMutableArray * possiblewords;
} 

//Initializes the word to a certain length, empties already guessed letters
- (void)initWord;

//gues a letter! Returns true if the word is guessed
- (bool)guessLetter:(unichar)letter;

@property(copy) NSMutableString *userword;

@end
