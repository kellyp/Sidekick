//
//  PKContainerView.m
//  Sidekick
//
//  Created by kelly on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PKContainerView.h"


@implementation PKContainerView

@synthesize moving;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        touchMovedPoint = CGPointMake(-1, -1);
        moving = NO;
    }
    return self;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [[touches allObjects] objectAtIndex:[touches count]-1];
    touchMovedPoint = [touch locationInView:self];

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    touchMovedPoint = CGPointMake(-1, -1);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
        touchMovedPoint = CGPointMake(-1, -1);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [[touches allObjects] objectAtIndex:[touches count]-1];
    float deltaY = [touch locationInView:self].y - touchMovedPoint.y;
    
    if (deltaY < -15 && !moving){
        moving = YES;
        //do animation
        [UIView beginAnimations:@"open window" context:nil];
        [UIView setAnimationDuration:.75];
        self.transform = CGAffineTransformMakeTranslation(0, -320);        
        [UIView commitAnimations];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
