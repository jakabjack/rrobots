//
//  Spot.m
//  rr
//
//  Created by jack on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Spot.h"
#import "Robot.h"


static const int numSpotTypes=4;


@implementation Spot


@synthesize coord = coord_;
@synthesize highlighted = highlighted_;


-(id)initWithType:(NSInteger)type color:(NSInteger)color
{
    self = [super init];
    if (self) {
        type_ = type;
        colorIndex_ = color;
    }
    
    return self;
}


-(void)fillSpecialPath:(CGContextRef)c rect:(CGRect)rect
{
    float edgeLen = rect.size.width *0.35;
    float offset1 = (rect.size.width-edgeLen)/2;

    //up
    CGPoint p = rect.origin;
    p.x += offset1; CGContextMoveToPoint(c, p.x, p.y);
    p.x += edgeLen; CGContextAddLineToPoint(c, p.x, p.y);
    
    //left
    p = rect.origin; p.x+=rect.size.width;
    p.y += offset1; CGContextAddLineToPoint(c, p.x, p.y);
    p.y += edgeLen; CGContextAddLineToPoint(c, p.x, p.y);
    
    //bottom
    p = (CGPoint){CGRectGetMaxX(rect), CGRectGetMaxY(rect)};
    p.x -= offset1; CGContextAddLineToPoint(c, p.x, p.y);
    p.x -= edgeLen; CGContextAddLineToPoint(c, p.x, p.y);
    
    //right
    p = rect.origin; p.y += rect.size.height;
    p.y -= offset1; CGContextAddLineToPoint(c, p.x, p.y);
    p.y -= edgeLen; CGContextAddLineToPoint(c, p.x, p.y);
    
    CGContextClosePath(c);
    CGContextFillPath(c);
}


-(void)render:(CGContextRef)context
{
    float x = self.coord.x*OffsetX;
    float y = self.coord.y*OffsetY;
    
    CGRect rect = CGRectMake(x, y, OffsetX, OffsetY);
    
    if (self.isHighlighted) {
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGRect highlightRect = CGRectInset(rect, 2, 2);
        CGContextFillRect(context, highlightRect);
    }
    
    //set color
    UIColor *uiColor = [[Robot orderedColors] objectAtIndex:colorIndex_];
    CGContextSetFillColorWithColor(context, uiColor.CGColor);
    
    switch (type_) {
        //planet type
        case 0: {
            //bg rect
            CGRect fillRect = CGRectInset(rect, rect.size.width*0.18, rect.size.height*0.18);
            CGContextFillRect(context, fillRect);
            
            //white circle
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGRect ellipseRect = CGRectInset(fillRect, fillRect.size.width*0.20, fillRect.size.height*0.20);
            CGContextFillEllipseInRect(context, ellipseRect);
            
            //white line
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextSetLineWidth(context, 2);
            CGContextMoveToPoint(context, fillRect.origin.x, CGRectGetMaxY(fillRect));
            CGContextAddLineToPoint(context, CGRectGetMaxX(fillRect), fillRect.origin.y);
            CGContextStrokePath(context);
        }
        break;
            
        //moon type
        case 1: {
            //bg circle
            CGRect fillRect = CGRectInset(rect, rect.size.width*0.18, rect.size.height*0.18);
            CGContextFillEllipseInRect(context, fillRect);
            
            //half-moon white
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGRect whiteEllipseRect = CGRectInset(fillRect, fillRect.size.width*0.20, fillRect.size.height*0.20);
            CGContextFillEllipseInRect(context, whiteEllipseRect);
            
            //half-moon bg col
            CGContextSetFillColorWithColor(context, uiColor.CGColor);
            CGRect bgColorRect = whiteEllipseRect;
            bgColorRect.origin = CGPointMake(bgColorRect.origin.x-rect.size.width*0.1, bgColorRect.origin.y);
            CGContextFillEllipseInRect(context, bgColorRect);
        }
        break;
            
        //triangle type
        case 2: {
            //background color triangle
            CGContextBeginPath(context);
            CGRect rect2 = CGRectInset(rect, OffsetX*0.18, OffsetY*0.18);
            CGContextMoveToPoint(context, rect2.origin.x+rect2.size.width/2, rect2.origin.y);
            CGContextAddLineToPoint(context, CGRectGetMaxX(rect2), CGRectGetMaxY(rect2));
            CGContextAddLineToPoint(context, CGRectGetMinX(rect2), CGRectGetMaxY(rect2));
            CGContextClosePath(context);
            CGContextFillPath(context);
            
            //white circle
            CGRect circleRect = CGRectInset(rect2, rect2.size.width*0.30, rect2.size.height*0.30);
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextFillEllipseInRect(context, circleRect);
            
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextSetLineWidth(context, 1.0);
            CGContextBeginPath(context);
            CGContextAddArc(context, CGRectGetMidX(circleRect), CGRectGetMidY(circleRect), circleRect.size.width/2, 0, 2*3.14, 1);
            CGContextClosePath(context);
            CGContextStrokePath(context);
        }
        break;
            
        //plus stop type
        case 3: {
            //bg color stop table
            CGRect rect2 = CGRectInset(rect, rect.size.width*0.18, rect.size.height*0.18);
            [self fillSpecialPath:context rect:rect2];
            
            //white cross
            CGRect rect3 = CGRectInset(rect2, rect2.size.width*0.05, rect2.size.height*0.05);
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextSetLineWidth(context, 5.0);
            
                //vert line
            CGPoint p = {CGRectGetMidX(rect3), rect3.origin.y};
            CGContextMoveToPoint(context, p.x, p.y);
            CGContextAddLineToPoint(context, p.x, p.y+rect3.size.height);
                //horiz line
            p = (CGPoint){rect3.origin.x, CGRectGetMidY(rect2)};
            CGContextMoveToPoint(context, p.x, p.y);
            CGContextAddLineToPoint(context, p.x+rect3.size.width, p.y);
            CGContextStrokePath(context);
        }
    }

}


+(NSArray *)allSpots
{
    NSMutableArray *spots = [NSMutableArray arrayWithCapacity:numSpotTypes*RobotColor_Num + 1];
    
    //4 types for every color
    for(int colorIndex=0; colorIndex<RobotColor_Num; colorIndex++) {
        for(int spotType = 0; spotType<numSpotTypes; spotType++) {
            Spot *spot = [[Spot alloc] initWithType:spotType color:colorIndex];
            [spots addObject:spot];
        }
    }
    
    //the rainbow type
    Spot *spot = [[Spot alloc] initWithType:-1 color:0];
    [spots addObject:spot];
    
    return [NSArray arrayWithArray:spots];
}



@end
