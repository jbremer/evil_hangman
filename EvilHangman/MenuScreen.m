//
//  MenuScreen.m
//  EvilHangman
//
//  Created by Jurriaan Bremer on 9/26/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "MenuScreen.h"
#import "PlayScreen.h"

@implementation MenuScreen

-(NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *_labels[] = {@"Play", @"Highscore", @"Settings", @"About"};

    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)] autorelease];
    [lbl setText:_labels[indexPath.row]];
    [cell addSubview:lbl];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController;
    switch (indexPath.row) {
        case 0:
            viewController = [[PlayScreen alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
    }
}

@end
