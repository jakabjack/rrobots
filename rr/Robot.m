//
//  Robot.m
//  rr
//
//  Created by jack on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Robot.h"
#import "Square.h"
#import "Table.h"
#import "NSArray+Utils.h"


@interface Robot()
@end


@implementation Robot


@synthesize coord = coord_;
@synthesize highlighted = highlighted_;
@synthesize color = colorIndex_;


-(id)initWithColor:(NSInteger)color
{
    self = [super init];
    
    if (self) {
        assert(color>=0 && color<RobotColor_Num);
        
        MyPoint p;
        p.x = rand() % NumSquares;
        p.y = rand() % NumSquares;
        self.coord = p;
        
        colorIndex_ = color;
    }
    
    return self;
}


-(void)render:(CGContextRef)context
{
    float x = self.coord.x*offsetX;
    float y = self.coord.y*offsetY;
    
    CGRect rect = CGRectMake(x, y, offsetX, offsetY);
    rect = CGRectInset(rect, 2, 2);
    
    if (self.isHighlighted) {
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGRect highlightRect = CGRectInset(rect, 2, 2);
        CGContextFillRect(context, highlightRect);
    }
    
    //set color
    UIColor *uiColor = [[Robot orderedColors] objectAtIndex:colorIndex_];
    CGContextSetFillColorWithColor(context, uiColor.CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    //lower circle
    float lowerRectPercent = 0.2;
    CGRect lowerRect = CGRectInset(rect, rect.size.width*lowerRectPercent, rect.size.height*lowerRectPercent);
    lowerRect.origin = CGPointMake(lowerRect.origin.x, lowerRect.origin.y+rect.size.height*lowerRectPercent);
    CGContextFillEllipseInRect(context, lowerRect);
    CGContextAddEllipseInRect(context, lowerRect);
    CGContextStrokePath(context);
    
    //uper circle
    float upperRectPercent = 0.3;
    CGRect upperRect = CGRectInset(rect, rect.size.width*upperRectPercent, rect.size.height*upperRectPercent);
    upperRect.origin = CGPointMake(upperRect.origin.x, upperRect.origin.y-rect.size.height*(upperRectPercent-0.08));
    CGContextFillEllipseInRect(context, upperRect);
    CGContextAddEllipseInRect(context, upperRect);
    CGContextStrokePath(context);
}


#pragma mark -
#pragma mark NSCopying


-(id)copyWithZone:(NSZone *)zone
{
    Robot *robot = [[Robot allocWithZone:zone] initWithColor:self.color];
    robot.coord = self.coord;
    robot.highlighted = self.highlighted;
    
    return robot;
}


#pragma mark -
#pragma mark static


+(NSArray *)orderedColors
{
    return [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor], nil];
}


@end
