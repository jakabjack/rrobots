//
//  Robot.h
//  rr
//
//  Created by jack on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPoint.h"


enum {
    RobotColor_Red = 0,
    RobotColor_Green,
    RobotColor_Blue,
    RobotColor_Yellow,
    
    RobotColor_Num
};


@interface Robot : NSObject <NSCopying>
{
    NSInteger colorIndex_;
}


@property (nonatomic, getter = isHighlighted) bool highlighted;
@property (nonatomic) MyPoint coord;
@property (nonatomic, readonly) NSInteger color;


-(id)initWithColor:(NSInteger)color;
-(void)render:(CGContextRef)context;


/** 
 * @returns the UIColor-s used for robots/spots in the following order: red, green blue, yellow; 
 * order is the same as in the RobotColor enum
 */
+(NSArray *)orderedColors;


@end
