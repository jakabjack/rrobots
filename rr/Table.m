//
//  Table.m
//  rr
//
//  Created by jack on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Table.h"
#import "ExtendedTable.h"
#import "MyPoint.h"
#import "ExtendedTable.h"
#import "TableBackground.h"
#import "Square.h"
#import "Robots.h"
#import "NSArray+Utils.h"
#import "Corner.h"
#import "Spot.h"
#import "Robot.h"


static int range = 6;
static int shrinkDelta = 0;




@interface Table()
-(void)randomA:(int *)a B:(int *)b;
-(void)placeCorner:(Corner *)corner;
-(bool)isCornerStandalone:(Corner *)corner;
@end


@implementation Table


@synthesize robots = robots_;


-(id)init
{
    self = [super init]; 
    
    if (self) {
        extendedTable_ = [[ExtendedTable alloc] init];
        
        //edges
        for(int i=0; i<NumSquares; i++) {
            [self placeCorner:[Corner cornerWithType:LeftOn coord:(MyPoint){0, i}]];
            [self placeCorner:[Corner cornerWithType:RightOn coord:(MyPoint){NumSquares-1,i}]];

            [self placeCorner:[Corner cornerWithType:TopOn coord:(MyPoint){i, 0}]];
            [self placeCorner:[Corner cornerWithType:BottomOn coord:(MyPoint){i, NumSquares-1}]];
        }
        
        //center
        [self placeCorner:[Corner cornerWithType:LeftOn|TopOn coord:(MyPoint){7, 7}]];
        [self placeCorner:[Corner cornerWithType:TopOn|RightOn coord:(MyPoint){8, 7}]];
        [self placeCorner:[Corner cornerWithType:RightOn|BottomOn coord:(MyPoint){8, 8}]];
        [self placeCorner:[Corner cornerWithType:BottomOn|LeftOn coord:(MyPoint){7, 8}]];
        
        int a, b;
        
        //top 2 edges
        [self randomA:&a B:&b];
        [self placeCorner:[Corner cornerWithType:LeftOn coord:(MyPoint){a, 0}]];
        [self placeCorner:[Corner cornerWithType:LeftOn coord:(MyPoint){b, 0}]];
        
        //right 2 edges
        [self randomA:&a B:&b];
        [self placeCorner:[Corner cornerWithType:TopOn coord:(MyPoint){NumSquares-1, a}]];
        [self placeCorner:[Corner cornerWithType:TopOn coord:(MyPoint){NumSquares-1, b}]];
        
        //bottom
        [self randomA:&a B:&b];
        [self placeCorner:[Corner cornerWithType:LeftOn coord:(MyPoint){a, NumSquares-1}]];
        [self placeCorner:[Corner cornerWithType:LeftOn coord:(MyPoint){b, NumSquares-1}]];
        
        //left
        [self randomA:&a B:&b];
        [self placeCorner:[Corner cornerWithType:TopOn coord:(MyPoint){0, a}]];
        [self placeCorner:[Corner cornerWithType:TopOn coord:(MyPoint){0, b}]];
        
        //put 17 corners on board
        NSArray *shuffledCorners = [[Corner toPlaceCorners] shuffled];
        for(Corner *corner in shuffledCorners) {
            
            bool isStandalone;
            do {
                MyPoint p = {arc4random()%(NumSquares-2) +1, arc4random()%(NumSquares-2) +1};
                corner.coord = p;
                isStandalone = [self isCornerStandalone:corner];
            } while (!isStandalone);
            
            [self placeCorner:corner];
        }
        
        //put 17 spots in the 17 corners
        spots_ = [[Spot allSpots] shuffled];
        for(int i=0; i<spots_.count; i++) {
            assert(i<shuffledCorners.count);
            
            Spot *spot = [spots_ objectAtIndex:i];
            spot.coord = [[shuffledCorners objectAtIndex:i] coord];
        }
        
        int targetSpotIndex = arc4random()%spots_.count;
        targetSpot_ = [spots_ objectAtIndex:targetSpotIndex];
        targetSpot_.highlighted = YES;
        
        //generate robots
        robots_ = [[Robots alloc] init];
        
        //mark in extended table as occupied
        for(Robot *robot in robots_.robots) {
            [extendedTable_ set:robot.coord];
        }
    }
    
    return self;
}


-(void)move:(MyPoint)offset
{
    Robot *robot = self.robots.selectedRobot;
    MyPoint originalCoord = robot.coord;
    int (*et)[M] = extendedTable_.innerTable;
    
    while (et[2*robot.coord.x+1 +offset.x][2*robot.coord.y+1 +offset.y]==0  //wall
        && et[2*robot.coord.x+1 +2*offset.x][2*robot.coord.y+1 +2*offset.y]==0) //another robot
    {
        robot.coord = (MyPoint){robot.coord.x+offset.x, robot.coord.y+offset.y};
    }
    
    //unmark/mark spot in extended table
    [extendedTable_ unset:originalCoord];
    [extendedTable_ set:robot.coord];
}


-(void)moveAbsolute:(MyPoint)coord
{
    Robot *selectedRobot = self.robots.selectedRobot;
    MyPoint originalCoord = selectedRobot.coord;
    
    //set new coord
    selectedRobot.coord = coord;
    
    [extendedTable_ unset:originalCoord];
    [extendedTable_ set:selectedRobot.coord];
}


-(void)resetRobotPositions
{
    for(Robot *robot in robots_.robots) {
        [extendedTable_ unset:robot.coord];
    }
    
    [self.robots reset];

    for(Robot *robot in robots_.robots) {
        [extendedTable_ set:robot.coord];
    }
}


#pragma mark -
#pragma mark private


-(int)randomNum
{
    int numToReturn;
    
    int randomNum = arc4random() % range;
    numToReturn = randomNum+shrinkDelta;
    
    if (shrinkDelta==0 && randomNum==0) {
        range-=2;
        shrinkDelta+=1;
    }
    
    return numToReturn;
}


//BBBBBBBBBBBBBBBB
//  |           |   
//BBBBBBBBBBBBBBBB
//       | |            
-(void)randomA:(int *)a B:(int *)b 
{
    //first number: 2-7
    *a = [self randomNum]+2;
    
    //second number: 9-14
    *b = [self randomNum]+9;
}


-(void)placeCorner:(Corner *)corner
{
    //place in table
    assert(corner.coord.x<NumSquares && corner.coord.y<NumSquares);
    t_[corner.coord.x][corner.coord.y] |= corner.type;

    [extendedTable_ placeCorner:corner];
}


-(bool)isCornerStandalone:(Corner *)corner
{
    assert(corner.coord.x<NumSquares && corner.coord.y<NumSquares);

    NSEnumerator *extendedPointsIt = corner.extendedPoints.objectEnumerator;
    NSValue *extendedPointValue = nil;
    bool isStandalone = true;
    
    while (isStandalone && (extendedPointValue = extendedPointsIt.nextObject) ) {
        MyPoint ep;
        [extendedPointValue getValue:&ep];
        isStandalone = [extendedTable_ isEdgeStandalone:ep];
    }
    
    return isStandalone;
}


//-(void)render:(CGContextRef)context 
//{
//    for(int i=0; i<N; i++) {
//        for(int j=0; j<N; j++) {
//            int cellData = t_[i][j];
//            
//            int x = offsetX*i;
//            int y = offsetY*j;
//            
//            CGContextMoveToPoint(context, x, y);
//
//            (cellData & TopOn) 
//                ? CGContextAddLineToPoint(context, x+offsetX, y)
//                : CGContextMoveToPoint(context, x+offsetX, y);
//            
//            (cellData & RightOn)
//                ? CGContextAddLineToPoint(context, x+offsetX, y+offsetY)
//                : CGContextMoveToPoint(context, x+offsetX, y+offsetY);
//            
//            (cellData & BottomOn) 
//                ? CGContextAddLineToPoint(context, x, y+offsetY)
//                : CGContextMoveToPoint(context, x, y+offsetY);
//            
//            (cellData & LeftOn)
//                ? CGContextAddLineToPoint(context, x, y)
//                : false ;
//
//            CGContextStrokePath(context);
//        }
//    }
//}
//
//


#pragma mark -
#pragma mark public


-(void)render:(CGContextRef)context
{
    TableBackground *tableBackground = [[TableBackground alloc] initWithContext:context];
    [tableBackground draw];
    
    for(Spot *spot in spots_) {
        [spot render:context];
    }

    [robots_ render:context];

    //render extended table
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    [extendedTable_ render:context];
}



@end
