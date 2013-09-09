//
//  ThumbtackField.h
//  iMinesweeper
//
//  Created by Emerson Carvalho on 9/9/13.
//  Copyright (c) 2013 Emerson Carvalho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbtackField : UIButton
{
    bool hasMine;
    bool hasClicked;
    int coordX;
    int coordY;
}
@property (nonatomic, assign) bool hasMine;
@property (nonatomic, assign) bool hasClicked;
@property (nonatomic, assign) int coordX;
@property (nonatomic, assign) int coordY;

-(BOOL) checkPositionIsX:(int)x andY:(int)y;

-(void) showMine;
-(void) showOpen;

@end
