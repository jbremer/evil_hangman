//
//  Dictionary.m
//  EvilHangman
//
//  Created by Victor Azizi on 9/23/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary

@synthesize userword;
@synthesize difficulty;

-(id)init {
    self = [super init];
    if(self) {
        difficulty = 1;
        possiblewords = [[NSMutableArray alloc] initWithCapacity:100];

        //Initialize the Dictionary @TODO pthreads
        // Such a lovely implementation... ;D
        NSString *file_name = [[NSBundle mainBundle] pathForResource:@"words1" ofType:@"txt"];
        NSString *file_contents = [NSString stringWithContentsOfFile:file_name encoding:NSUTF8StringEncoding error:nil];
        dict = [file_contents componentsSeparatedByString:@"\n"];
        [dict retain];
    }
    return self;
}

-(void)initWord {
    //Clean everything
    for (int i = 0; i < 26; i++) {
        guessedletters[i] = false;
    }
    [possiblewords removeAllObjects];

    //Initialize everything
    int index = arc4random() % [dict count];
    NSString *ourword = [dict objectAtIndex:index];

    userword = [[NSMutableString alloc] init];
    for (int i = 0; i < ourword.length; i++) {
        [userword appendString:@"*"];
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

-(int)guessLetter:(unichar)ch {
    int notfound = 0;

    if(ch < 'a' || ch > 'z') {
        // TODO: notify user
        return 1;
    }

    if(guessedletters[ch - 'a'] != false) {
        // already guessed this letter
        return 2;
    }

    guessedletters[ch - 'a'] = true;

    NSString *s = [NSString stringWithCharacters:&ch length:1];

    // check for a word that is not yet found
    for (NSString *word in possiblewords) {
        if([word rangeOfString:s].location == NSNotFound) {
            notfound = 1;
            break;
        }
    }

    if(notfound) {
        // remove all words with the letter if we have at least one entry left without the letter
        for (int i = 0; i < possiblewords.count; i++) {
            if([[possiblewords objectAtIndex:i] rangeOfString:s].location != NSNotFound) {
                [possiblewords removeObjectAtIndex:i];
                i--;
            }
        }
        return 3;
    }
    else {
        // choose a word to use if we must fill in the letter
        // TODO: not random?
        NSString *ourword = [possiblewords objectAtIndex:arc4random() % [possiblewords count]];
        int indices[10] = {0}, j = 0;

        // fill it and remember where
        for (int i = 0; i < ourword.length; i++) {
            if([ourword characterAtIndex:i] == ch) {
                [userword replaceCharactersInRange:NSMakeRange(i, 1) withString:s];
                indices[j] = i;
                j++;
            }
        }

        // remove words that dont have the characters at the same place
        for (int i = 0; i < possiblewords.count; i++) {
            NSString *word = [possiblewords objectAtIndex:i];
            for (int k = 0; k < j; k++) {
                if([word characterAtIndex:indices[k]] != ch) {
                    [possiblewords removeObjectAtIndex:i];
                    i--;
                    break;
                }
            }
        }

        // check if the user guessed the whole word
        if([userword rangeOfString:@"*"].location == NSNotFound) {
            return 5;
        } else {
            return 4;
        }
    }
}

- (void)dealloc {
    [possiblewords release];
    [dict release];
    [super dealloc];
}
@end
