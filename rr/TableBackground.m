//
//  TableBackground.m
//  rr
//
//  Created by jack on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableBackground.h"
#import "ExtendedTable.h"
#import "Table.h"
#import "Square.h"


@implementation TableBackground


-(id)initWithContext:(CGContextRef)context
{
    self = [super init];
    
    if (self) {
        context_ = context;
    }
    
    return self;
}


#pragma mark -
#pragma mark private


-(void)drawSquareAt:(MyPoint)p
{
    float halfOffsetX = OffsetX/2;
    float halfOffsetY = OffsetY/2;

    //center
    float x = p.x*OffsetX+halfOffsetX;
    float y = p.y*OffsetY+halfOffsetY;
    
    //white half
    CGContextSetStrokeColorWithColor(context_, [UIColor whiteColor].CGColor);
    
    CGContextMoveToPoint(context_, x-halfOffsetX, y+halfOffsetY);
    CGContextAddLineToPoint(context_, x-halfOffsetX, y-halfOffsetY);
    CGContextAddLineToPoint(context_, x+halfOffsetX, y-halfOffsetY);
    CGContextStrokePath(context_);
}


#pragma mark -
#pragma mark public


-(void)draw
{
    CGContextSetLineWidth(context_, 1.0);
    
    for(int x=0; x<NumSquares; x++) {
        for(int y=0; y<NumSquares; y++) {
            [self drawSquareAt:(MyPoint){x, y}];
        }
    }

}


@end
