//
//  Dictionary.m
//  EvilHangman
//
//  Created by Victor Azizi on 9/23/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary


- (id)init {
    self = [super init];
    if (self) {
        difficulty = 1;
        userword = calloc(1, sizeof(char)*100);
        guessedletters = calloc(1, sizeof(char)*27);
        dict = [NSMutableArray arrayWithCapacity:100];
        possiblewords = [NSMutableArray arrayWithCapacity:100];
       // ourword = 0;
    }
    
    //Initialize the Dictionary @TODO pthreads
    FILE * words = fopen("r", "words");
    unsigned long maxwordlength = 100;
    char next[maxwordlength]; 
    while ((fgets(next, maxwordlength, words))) {
        [dict addObject:[NSString stringWithUTF8String:next]];
    }
    
    return self;
}

- (void) initWord {
    int i;
    
    //Clean everything
    guessedletters[0] = '\0';
    [possiblewords removeAllObjects];
    
    //Initialize everything
    int index = arc4random() % [dict count];
    NSString * ourword = [dict objectAtIndex:index];
    int length = [ourword length];
    
    for (i = 0; i < length; i++) {
        userword[i]='_';
    }
    userword[i]='\0';
    
    for (NSString * word in dict) {
        if ([word length] == length)
            [possiblewords addObject:word];
    }
    
}

- (bool) guessLetter:(char)letter {
    char letterstring[2] = {0};
    letterstring[0] = letter;
    int notfound = 0;
    
    strcat(guessedletters, letterstring);
    
    //if the letter is found, check for a word that is not yet found and replace ourword
    for (NSString * word in possiblewords) {
        if ([word rangeOfString:[NSString stringWithUTF8String:letterstring]].location
                == NSNotFound) {        
            //ourword = word;
            notfound = 1;
            break;
        }
    }
    
    //Remove all words with the letter if we have at least one entry left without the letter
    if (notfound) {
        for (int i = 0; i < [possiblewords count]; i++) {
            if ([[possiblewords objectAtIndex:i] rangeOfString:[NSString 
                    stringWithUTF8String:letterstring]].location != NSNotFound) {
                [possiblewords removeObjectAtIndex:i];
            }
        }
        return false;
        
    } else {
        
        //Choose a word to use if we must fill in the letter @TODO not random?
        NSString * ourword = [possiblewords objectAtIndex:arc4random() % [possiblewords count]];
        int indices[10] = {0};
        int j = 0;
        
        //Fill it and remember where
        for (int i = 0; i < [ourword length] ; i++) {
            if ([ourword characterAtIndex:i] == letter) {
                userword[i] = letter;
                indices[j] = i;
                j++;
            }
        }
        
        //Remove words that dont have the characters at the same place
        for (int i = 0; i < [possiblewords count]; i++) {
            NSString * word = [possiblewords objectAtIndex:i];
            for (int k = j ; k < j ; k++) {
                if (![word characterAtIndex:indices[k]] == letter) {
                    [possiblewords removeObjectAtIndex:i];
                }
            }
        }
        
        //Check if the user guessed the whole word
        for (int i = 0 ; i < strlen(userword); i++) {
            if (userword[i] == '_') return false;
        }
        return true;
    }
}
    
@end