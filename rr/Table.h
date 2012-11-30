//
//  Table.h
//  rr
//
//  Created by jack on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPoint.h"


enum {
    NumSquares = 16 //number of horizontal/vertical squares
};


enum TableDir {
    TableDir_Left=0,
    TableDir_Up,
    TableDir_Right,
    TableDir_Down,
    
    TableDir_Num
};


@class ExtendedTable;
@class Spot;
@class Robots;


@interface Table : NSObject
{
    int t_[NumSquares][NumSquares];
    ExtendedTable *extendedTable_;
    
    NSArray *spots_;
    Spot *targetSpot_;
    
    Robots *robots_;
}


@property (nonatomic, readonly) Robots *robots;

-(void)render:(CGContextRef)context;

//moves the currently selected robot into the specified direction till it bumps into something
-(void)move:(MyPoint)directionOffset;

//moves the currently selected robot to an absolute coordinate
-(void)moveAbsolute:(MyPoint)coord;

//resets the robot positions to the initial pos
-(void)resetRobotPositions;


@end
