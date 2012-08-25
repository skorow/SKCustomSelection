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
//  SMKCustomMenu.m
//  SKCustomSelection
//
//  Created by Stephen Korow on 8/23/12.
//  Copyright (c) 2012 Stephen Korow. All rights reserved.
//

#define OFF_IMAGE	       [UIImage imageNamed:@"up.png"]
#define ON_IMAGE	       [UIImage imageNamed:@"down.png"]
#define BAR_COLOR          [UIColor colorWithRed:0.756863f green:0.756863f blue:0.756863f alpha:1.0f]
#define BACKGROUND_COLOR   [UIColor colorWithRed:0.921569f green:0.921569f blue:0.921569f alpha:1.0f]

#import "SMKCustomMenu.h"

@implementation SMKCustomMenu

//@synthesize value;
@synthesize segments;
@synthesize selectedSegmentIndex;
@synthesize barColor;
@synthesize theBackgroundColor;

int numberOfButtons = 0;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selectedSegmentIndex = 0;
        numberOfButtons = segments.count;
		self.frame = CGRectMake(0.0f, 0.0f, 320, 80);
        
        //create the background bar connecting the buttons
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 240.0f, 10.0f)];
        view.backgroundColor = BAR_COLOR;
        view.center = CGPointMake(self.frame.size.width / 2.0f,35);
        view.tag = 2;
        [self addSubview:view];
        
		float offsetCenter = 40;
		
        for (int i = 1; i <= numberOfButtons; i++)
		{
            //create the row of buttons
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
			imageView.image = OFF_IMAGE;
            imageView.center = CGPointMake(offsetCenter, 35);
            imageView.tag = 100+i;
			[self addSubview:imageView];
            
            //create the row of labels
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 30.0f)];
            label.textColor = [UIColor colorWithRed:0.656863f green:0.656863f blue:0.656863f alpha:1.0f];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:13];
            label.text = (NSString *)[segments objectAtIndex:(i-1)];
            label.alpha = 1.0;
            label.textAlignment = UITextAlignmentCenter; 
            label.center = CGPointMake(offsetCenter, 60);
            label.tag = 200+i;
            [self addSubview:label];
            
            offsetCenter += 240 / (numberOfButtons - 1);
		}
        self.backgroundColor = BACKGROUND_COLOR;
        self.tag = 1;
    }
    return self;
}

- (id)initWithItems:(NSArray *)items {
    if (items.count < 2)
    {
        NSLog(@"ERROR: You need to send at least two array items when creating the SMCustomMenu instance.");
        return nil;
    }
    else {
        self.segments = [NSArray arrayWithArray:items];
        self = [super init];
        return self;

    }
}

-(void) buttonPushed:(float)x_value:(float)y_value
{
    float offsetCenter = 40;
    for (int i = 1; i <= numberOfButtons; i++)
    {
        if (x_value > (offsetCenter-10) && x_value < (offsetCenter + 10))
        {
            if (selectedSegmentIndex != 0)
            {
                //reset the old button to unpressed.
                UIImageView *oldView = (UIImageView *)[self viewWithTag:(100+selectedSegmentIndex)];
                oldView.image = OFF_IMAGE;
                UILabel *oldlabel = (UILabel *)[self viewWithTag:(200+selectedSegmentIndex)];
                oldlabel.textColor = [UIColor colorWithRed:0.656863f green:0.656863f blue:0.656863f alpha:1.0f];
            }
            // set the selected button to pressed
            UIImageView *newView = (UIImageView *)[self viewWithTag:(100+i)];
            newView.image = ON_IMAGE;
            UILabel *newlabel = (UILabel *)[self viewWithTag:(200+i)];
            newlabel.textColor = [UIColor blackColor];
            
            selectedSegmentIndex = i;
            [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        offsetCenter += 240 / (numberOfButtons - 1);
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, touchPoint))
    {
        if (touchPoint.y > 24 && touchPoint.y < 46)
        {
            [self buttonPushed:touchPoint.x :touchPoint.y];
        }
    }   
}

-(void)resetBackgroundColors
{
    UIView *barView = (UIView *)[self viewWithTag:2];
    barView.backgroundColor =  BAR_COLOR; 
    self.backgroundColor =  BACKGROUND_COLOR;

}

-(void) setBarColor:(UIColor *)newBarColor
{
    self->barColor = newBarColor;
    UIView *barView = (UIView *)[self viewWithTag:2];
    barView.backgroundColor =  self.barColor;  
}

-(void) setTheBackgroundColor:(UIColor *)newBackgroundColor
{
    self->theBackgroundColor = newBackgroundColor;
    //UIView *backgoundView = (UIView *)[self viewWithTag:1];
    self.backgroundColor =  self.theBackgroundColor;  
}

- (id) init
{
	return [self initWithFrame:CGRectZero];
}


@end
