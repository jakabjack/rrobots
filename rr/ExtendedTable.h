//
//  ExtendedTable.h
//  rr
//
//  Created by jack on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPoint.h"


#define M 33 //should be 2*NumSquares + 1


@class Corner;


/**
 * (x, y) - table coordinates
 * (ex, ey) - extended table coordinates
 *
 * size of extended table: 2 * x + 1 the size of original table
 * 
 * How it works:
 * for cell (x, y) in original table => (xe, ye) = (2*x+1, 2*y+1) in extended table
 *  - (xe-1, ye) - left side of current cell
 *  - (xe+1, ye) - right side of current cell
 *  - (xe, ye-1) - upper side
 *  - (xe, ye+1) - lower side
 *
 * each square in extendedtable can be 0 or 1; 1 means that place is occupied (can be a wall, a robot, etc...)
 */
@interface ExtendedTable : NSObject
{
    int et_[M][M];
}


-(int(*)[M])innerTable;


/**
 * checks whethe the edge touches other edges or not
 * two edges are considered touching if they have a common point
 */
-(bool)isEdgeStandalone:(MyPoint)p;

-(void)render:(CGContextRef)context;

/** 
 * @param coord in table coordinates 
 * transform coord to extended table coordinates
 * marks cell in extended table as occupied by simply putting a 1 in that cell
 */
-(void)set:(MyPoint)coord;

/** @param coord in table coordinates */
-(void)unset:(MyPoint)coord;

-(void)placeCorner:(Corner *)corner;


@end
