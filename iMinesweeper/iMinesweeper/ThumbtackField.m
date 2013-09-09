//
//  ThumbtackField.m
//  iMinesweeper
//
//  Created by Emerson Carvalho on 9/9/13.
//  Copyright (c) 2013 Emerson Carvalho. All rights reserved.
//

#import "ThumbtackField.h"
#import <QuartzCore/QuartzCore.h>

@implementation ThumbtackField

@synthesize hasClicked, hasMine, coordX, coordY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"grass.jpg"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setHasClicked:NO];
        [[self layer] setCornerRadius:3.0f];
        [[self layer] setMasksToBounds:YES];
        [[self layer] setBorderWidth:0.5f];
        [self setCoordX: 0];
        [self setCoordY: 0];
    }
    return self;
}

-(BOOL) checkPositionIsX:(int)x andY:(int)y
{
    return (self.coordX == x && self.coordY == y);
}

-(void) showMine
{
    [self setBackgroundImage:[UIImage imageNamed:@"bomb.jpg"] forState:UIControlStateNormal];
}

-(void) showOpen
{
    [self setBackgroundImage:[UIImage imageNamed:@"open.jpg"] forState:UIControlStateNormal];
}

@end
