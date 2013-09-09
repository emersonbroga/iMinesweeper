//
//  ThumbtackMap.m
//  iMinesweeper
//
//  Created by Emerson Carvalho on 9/9/13.
//  Copyright (c) 2013 Emerson Carvalho. All rights reserved.
//

#import "ThumbtackMap.h"


@implementation ThumbtackMap

@synthesize squares, mines, clicks, gameRunning;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}


- (void) createFields
{
    self.gameRunning = YES;
    
    NSMutableArray *mineMap = [self setMines: self.mines inRange: self.squares* self.squares];
    // get the size of each field
    float sizeWidth = (self.frame.size.width/self.squares);
    float sizeHeight = (self.frame.size.height/self.squares);
    
    // counting cartezian positions
    int positionX = 0;
    int positionY = 0;
    
    // place each field in the map
    for (int i = 0; i < self.squares*self.squares; i++) {
        
        CGRect position = CGRectMake(sizeWidth * positionX, sizeHeight * positionY, sizeWidth, sizeHeight);
        ThumbtackField *field = [[ThumbtackField alloc] init];
        [field setFrame:position];
        [field setTag:i+1000]; //to avoid overwrite
        [field addTarget:self action:@selector(fieldClick:) forControlEvents:UIControlEventTouchUpInside];
        [field setHasMine:[[mineMap objectAtIndex: i] boolValue]];
        [field setCoordX:positionX];
        [field setCoordY:positionY];
        [field setHasClicked: NO];
        
        [self addSubview:field];
        
        // set up for the next field
        if((positionX+1) < self.squares){
             positionX++;
        }else{
            positionX = 0;
            positionY++;
            
        }
    }
    
}

-(void) fieldClick:(ThumbtackField *) field {

    if(field.hasClicked == YES ){
        return;
    }
    
    field.hasClicked = YES;
    self.clicks++;
    if( field.hasMine == YES ){
        self.clicks--;
        [field showMine];
        [self showAllMines];
        // open an alert with just an OK button
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Soldier Minesweeper"
                                                        message:@"You Failed Soldier!"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
        [alert show];
        self.gameRunning = NO;
        return;
    }else{
        
        [field showOpen];
        [self checkAdjacentFieldsOf:field];
    }
    
}


-(void) checkAdjacentFieldsOf:(ThumbtackField *) field
{
    // top x = x & y = y-1
    int topX = field.coordX;
    int topY = field.coordY - 1;
    
    // bottom x = x & y = y+1
    int bottomX = field.coordX;
    int bottomY = field.coordY + 1;
    
    // left x = x -1 & y = y
    int leftX = field.coordX - 1;
    int leftY = field.coordY;
    
    // right x = x +1 & y = y
    int rightX = field.coordX + 1;
    int rightY = field.coordY;
    
    // topRight x = x + 1 & y = y
    int topRightX = topX + 1;
    int topRightY = topY;
    
    // topLeft x = x - 1 & y = y
    int topLeftX = topX - 1;
    int topLeftY = topY;
    
    // bottomRight x = x + 1 & y = y
    int bottomRightX = bottomX + 1;
    int bottomRightY = bottomY;
    
    // bottomLeft x = x - 1 & y = y
    int bottomLeftX = bottomX - 1;
    int bottomLeftY = bottomY;
    
    
    NSMutableArray *adjacentsToClick = [NSMutableArray array];
    int found = 0;
    for (int i = 0; i < self.squares * self.squares; i++) {
        
        ThumbtackField *adjacent = (ThumbtackField *)[self viewWithTag: i+1000];
        
        if([adjacent checkPositionIsX:topX andY:topY]){
            // check top
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }else if([adjacent checkPositionIsX:bottomX andY:bottomY]){
            // check bottom
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }else if([adjacent checkPositionIsX:leftX andY:leftY]){
            // check left
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }else if([adjacent checkPositionIsX:rightX andY:rightY]){
            // check right
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }else if([adjacent checkPositionIsX:topRightX andY:topRightY]){
            // check topRight
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }else if([adjacent checkPositionIsX:topLeftX andY:topLeftY]){
            // check topLeft
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }else if([adjacent checkPositionIsX:bottomRightX andY:bottomRightY]){
            // check bottomRight
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }else if([adjacent checkPositionIsX:bottomLeftX andY:bottomLeftY]){
            // check bottomLeft
            [adjacentsToClick addObject:adjacent];
            if(adjacent.hasMine)
                found++;
        }
                
        if(found > 0){
            [field setTitle:[NSString stringWithFormat:@"%d", found] forState:UIControlStateNormal];
        }
    }
    
    if(found == 0){
        for (int i = 0; i < adjacentsToClick.count; i++) {
            
            ThumbtackField *fieldToClick = [adjacentsToClick objectAtIndex:i];
            if(fieldToClick.hasClicked == NO){
                [fieldToClick sendActionsForControlEvents: UIControlEventTouchUpInside];
            }
        }
    }
}

-(void) showAllMines
{
    for (int i = 0; i < self.squares * self.squares; i++) {
        ThumbtackField *field = (ThumbtackField *)[self viewWithTag: i+1000];
        
        if(field.hasClicked == NO && field.hasMine == YES){
            [field showMine];
        }
    }

}

-(bool) playerWin
{
    return ((self.clicks+self.mines) == (self.squares * self.squares));
}

- (NSMutableArray *) setMines:(int) minesQuantity inRange:(int) maxRange
{
    // create a mine map array
    NSMutableArray *mineMap = [NSMutableArray array];
    int mineCount = 0;
    
    // set it without mines
    for (NSInteger i = 0; i < maxRange; i++){
        [mineMap addObject: [NSNumber numberWithBool:NO]];
    }
    // place mines and prevent mine overwrite
    while (mineCount < minesQuantity) {
        
        int key = [self getRandomNumberBetween:0 to:maxRange];
        if([[mineMap objectAtIndex: key] boolValue] == NO){
            [mineMap insertObject:[NSNumber numberWithBool:YES] atIndex:key];
            
            mineCount++;
        }
    }
    return mineMap;
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int) from + arc4random() % (to-from);
}

@end
