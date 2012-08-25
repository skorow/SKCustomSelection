/*
 This file is part of SKCustomSelection.
 
 Copyright (c) 2012, Stephen Korow
 All rights reserved.
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */


//
//  SMKViewController.m
//  SKCustomSelection
//
//  Created by Stephen Korow on 8/23/12.
//  Copyright (c) 2012 Stephen Korow. All rights reserved.
//

#import "SMKViewController.h"


@interface SMKViewController ()

@end

@implementation SMKViewController


-(void) setBarColorToBlack
{
    smkCustomMenu.barColor = [UIColor blackColor]; 
}

- (void) setBackgroundColorToBlue
{
    smkCustomMenu.theBackgroundColor = [UIColor blueColor];
}

- (void) resetColors
{
    [smkCustomMenu resetBackgroundColors];
}

- (void) valueChanged: (SMKCustomMenu *) customMenu
{
	label.text = [NSString stringWithFormat:@"Button %d was pressed.", customMenu.selectedSegmentIndex];
}


- (void) loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Add the menu
    NSArray *itemArray = [NSArray arrayWithObjects:@"Now", @"Today", @"Tomorrow", @"Weekend", nil];
    smkCustomMenu = [[SMKCustomMenu alloc] initWithItems:itemArray];
    [self.view addSubview:smkCustomMenu];
    
    // Add a label to display the value of the selected menu item. 
    label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 320, 30);
    label.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"No Button Selected";
    [self.view addSubview:label];
    
    //add a button to demonstrate setting a property in the control
    buttonSetBarColor = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonSetBarColor.frame = CGRectMake(0,0,230,28);
    buttonSetBarColor.center = CGPointMake(CGRectGetMidX(self.view.bounds), 300);
    [buttonSetBarColor setTitle:@"Set Bar Color Black" forState:UIControlStateNormal];
    [buttonSetBarColor setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonSetBarColor addTarget:self action:@selector(setBarColorToBlack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSetBarColor];
    
    //add a button to demonstrate setting a property in the control
    buttonSetBackgroundColor = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonSetBackgroundColor.frame = CGRectMake(0,0,230,28);
    buttonSetBackgroundColor.center = CGPointMake(CGRectGetMidX(self.view.bounds), 340);
    [buttonSetBackgroundColor setTitle:@"Set Background Color Blue" forState:UIControlStateNormal];
    [buttonSetBackgroundColor addTarget:self action:@selector(setBackgroundColorToBlue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSetBackgroundColor];
    
    //add a button to reset properties in the control
    buttonResetColor = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonResetColor.frame = CGRectMake(0,0,230,28);
    buttonResetColor.center = CGPointMake(CGRectGetMidX(self.view.bounds), 380);
    [buttonResetColor setTitle:@"Reset Colors" forState:UIControlStateNormal];
    [buttonResetColor setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonResetColor addTarget:self action:@selector(resetColors) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonResetColor];
    
    [smkCustomMenu addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside]; 
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
