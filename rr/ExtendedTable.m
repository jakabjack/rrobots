//
//  ExtendedTable.m
//  rr
//
//  Created by jack on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "ExtendedTable.h"
#import "Table.h"
#import "Corner.h"


/** goOnY = true (because edge is oriented on Y axis)
 * . . . a .    |
 * . . b . c   - - 
 * . . . | .    *    the * marked is the edge checked
 * . . d . e   - -
 * . . . f .    |
 */
static const MyPoint offsetsOnY[] = {
    {0, -2},   //a
    {-1, -1},  //b
    {1, -1},   //c
    {-1, 1},   //d
    {1, 1},    //e
    {0, 2}     //f 
};
static const int numOffsetsOnY = sizeof(offsetsOnY)/sizeof(MyPoint);


MyPoint shift(MyPoint p, MyPoint offset, bool onY)
{
    offset = onY ? offset : (MyPoint){offset.y, offset.x};
    
    MyPoint shiftedP = p;
    shiftedP.x += offset.x;
    shiftedP.y += offset.y;
    
    return shiftedP;
}


@implementation ExtendedTable


-(bool)isEdgeStandalone:(MyPoint)p 
{
    assert(p.x!=p.y);
    assert(p.x%2 ? !(p.y%2) : p.y%2);
    
    bool goOnY = p.y%2;
    
    bool isStandalone = true;
    for(int i=0; i<numOffsetsOnY && isStandalone; i++) {
        MyPoint q = shift(p, offsetsOnY[i], goOnY);
        if (0<=q.x && q.x<M && 0<=q.y && q.y<M) {
            isStandalone = !et_[q.x][q.y];
        }
    }
    
    return isStandalone;
}


-(int(*)[M])innerTable
{
    return et_;
}


-(void)render:(CGContextRef)context
{
    for(int x=0; x<NumSquares; x++) {
        for(int y=0; y<NumSquares; y++) {
            int ex = 2*x +1;
            int ey = 2*y +1;
            
            int grX = x*offsetX;
            int grY = y*offsetY;
            
            if (et_[ex-1][ey]) {
                //left
                CGContextMoveToPoint(context, grX, grY);
                CGContextAddLineToPoint(context, grX, grY+offsetY);
            }
            
            if (et_[ex][ey-1]) {
                //top 
                CGContextMoveToPoint(context, grX, grY);
                CGContextAddLineToPoint(context, grX+offsetX, grY);
            }
            
            if (x==NumSquares-1 && et_[ex+1][ey]) {
                //last right
                CGContextMoveToPoint(context, grX+offsetX, grY);
                CGContextAddLineToPoint(context, grX+offsetX, grY+offsetY);
            }
            
            if (y==NumSquares-1 && et_[ex][ey+1]) {
                //last bottom
                CGContextMoveToPoint(context, grX, grY+offsetY);
                CGContextAddLineToPoint(context, grX+offsetX, grY+offsetY);
            }
            
            CGContextStrokePath(context);
        }
    }
}


-(void)set:(MyPoint)c
{
    assert(0==et_[2*c.x+1][2*c.y+1]);
    et_[2*c.x+1][2*c.y+1] = 1;
}


-(void)unset:(MyPoint)c
{
    assert(1==et_[2*c.x+1][2*c.y+1]);
    et_[2*c.x+1][2*c.y+1] = 0;
}


-(void)placeCorner:(Corner *)corner
{
    NSArray *extendedPoints = [corner extendedPoints];
    for(NSValue *pointValue in extendedPoints) {
        MyPoint p;
        [pointValue getValue:&p];
        
        et_[p.x][p.y] = et_[p.x][p.y] || 1;
    }
}


-(NSString *)description
{
    NSMutableString *str = [[NSMutableString alloc] init];
    for(int i=0; i<M; i++) {
        for(int j=0; j<M; j++) {
            [str appendFormat:@"%d", et_[j][i]];
        }
        [str appendString:@"\n"];
    }
    
    return str;
}


@end

