//
//  Settings.m
//  EvilHangman
//
//  Created by Victor Azizi on 10/4/12.
//  Copyright (c) 2012 Lolcat, Inc. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize sliderLabel;
@synthesize difficultyLabel;

-(void) sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.sliderLabel.text=[[[NSString alloc] initWithFormat:@"%d", (int)(slider.value + 0.5f)] autorelease];
}
-(void) difficultyChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.sliderLabel.text=[[[NSString alloc] initWithFormat:@"%d", (int)(slider.value + 0.5f)] autorelease];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    //Build le UI
    printf(" ");
    UILabel *desc = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 180, 40)] autorelease];
    UILabel *desc2 = [[[UILabel alloc] initWithFrame:CGRectMake(20, 140, 120, 20)] autorelease];
    desc.text = [[[NSString alloc] initWithFormat:@"Number of Guesses:"] autorelease];
    desc2.text = [[[NSString alloc] initWithFormat:@"Evil mode:"] autorelease];
    
    UISlider *slider = [[[UISlider alloc] initWithFrame:CGRectMake(20, 40, 250, 40)] autorelease];
    slider.maximumValue=26;
    slider.minimumValue=4;
    
    UISwitch * difficulty = [[[UISwitch alloc] initWithFrame:CGRectMake(140, 140, 40, 40)] autorelease];
    
    //Bind le sliderlabel to le slider
    self.sliderLabel = [[[UILabel alloc] initWithFrame:CGRectMake(200, 0, 20, 40)] autorelease];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        
    [cell addSubview:desc];
    [cell addSubview:desc2];
    [cell addSubview:self.sliderLabel];
    [cell addSubview:slider];
    [cell addSubview:difficulty];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableView.scrollEnabled = NO;
    return 500;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            break;
        case 2:
            break;
    }
}

- (void)dealloc {
    [sliderLabel release];
    [super dealloc];
}
@end
