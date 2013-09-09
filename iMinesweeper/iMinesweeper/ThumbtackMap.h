//
//  ThumbtackMap.h
//  iMinesweeper
//
//  Created by Emerson Carvalho on 9/9/13.
//  Copyright (c) 2013 Emerson Carvalho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbtackField.h"

@interface ThumbtackMap : UIView
{
    int squares;
    int mines;
    int clicks;
    bool gameRunning;
}
@property (nonatomic, assign) int squares;
@property (nonatomic, assign) int mines;
@property (nonatomic, assign) int clicks;
@property (nonatomic, assign) bool gameRunning;

-(void) createFields;
-(NSMutableArray *) setMines:(int) minesQuantity inRange:(int) maxRange;
-(bool) playerWin;
-(void) showAllMines;

@end
