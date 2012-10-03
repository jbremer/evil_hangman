//
//  PlayScreen.h
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/22/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dictionary.h"

@interface PlayScreen : UIViewController <UIKeyInput> {
    Dictionary *dict;
}

@end
