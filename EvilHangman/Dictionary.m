//
//  Dictionary.m
//  EvilHangman
//
//  Created by Victor Azizi on 9/23/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary

-(id)init {
    self = [super init];
    if(self) {
        difficulty = 1;
        dict = [NSMutableArray arrayWithCapacity:100];
        possiblewords = [NSMutableArray arrayWithCapacity:100];

        //Initialize the Dictionary @TODO pthreads
        FILE *fp = fopen("words", "r");
        char next[100];
        while (fgets(next, 100, fp)) {
            [dict addObject:[NSString stringWithUTF8String:next]];
        }
        fclose(fp);
    }
    return self;
}

-(void)initWord {
    //Clean everything
    guessedletters[0] = 0;
    [possiblewords removeAllObjects];

    //Initialize everything
    int index = arc4random() % [dict count];
    NSString *ourword = [dict objectAtIndex:index];

    userword[ourword.length] = 0;
    for (int i = 0; i < ourword.length; i++) {
        userword[i] = '_';
    }

    //Honest mode implementation is easypeasy
    if(difficulty == 0) {
        [possiblewords addObject:ourword];
    }
    else {
        for (NSString *word in dict) {
            if(word.length == ourword.length) {
                [possiblewords addObject:word];
            }
        }
    }
}

-(bool)guessLetter:(char)letter {
    char letterstring[2] = {letter, 0};
    int notfound = 0;

    strcat(guessedletters, letterstring);

    //check for a word that is not yet found and replace ourword
    for (NSString *word in possiblewords) {
        if([word rangeOfString:[NSString stringWithUTF8String:letterstring]].location == NSNotFound) {
            notfound = 1;
            break;
        }
    }

    //Remove all words with the letter if we have at least one entry left without the letter
    if(notfound) {
        for (int i = 0; i < [possiblewords count]; i++) {
            if([[possiblewords objectAtIndex:i] rangeOfString:[NSString
                    stringWithUTF8String:letterstring]].location != NSNotFound) {
                [possiblewords removeObjectAtIndex:i];
            }
        }
        return false;
    }
    else {

        //Choose a word to use if we must fill in the letter @TODO not random?
        NSString *ourword = [possiblewords objectAtIndex:arc4random() % [possiblewords count]];
        int indices[10] = {0}, j = 0;

        //Fill it and remember where
        for (int i = 0; i < ourword.length; i++) {
            if([ourword characterAtIndex:i] == letter) {
                userword[i] = letter;
                indices[j++] = i;
            }
        }

        //Remove words that dont have the characters at the same place
        for (int i = 0; i < [possiblewords count]; i++) {
            NSString * word = [possiblewords objectAtIndex:i];
            for (int k = j ; k < j ; k++) {
                if([word characterAtIndex:indices[k]] != letter) {
                    [possiblewords removeObjectAtIndex:i];
                }
            }
        }

        //Check if the user guessed the whole word
        for (int i = 0 ; i < strlen(userword); i++) {
            if(userword[i] == '_') {
                return false;
            }
        }
        return true;
    }
}

@end
