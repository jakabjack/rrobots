//
//  Spot.h
//  rr
//
//  Created by jack on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MyPoint.h"


/** 
 * spot is the place on which a robot can and should arrive 
 * there are 17 different spots 
 */
@interface Spot : NSObject
{
    NSInteger type_;
    NSInteger colorIndex_;
}


@property (nonatomic) MyPoint coord;
@property (nonatomic, getter=isHighlighted) bool highlighted;


-(id)initWithType:(NSInteger)type color:(NSInteger)color;
-(void)render:(CGContextRef)context;


+(NSArray *)allSpots;


@end
