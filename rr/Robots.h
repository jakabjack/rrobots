//
//  Robots.h
//  rr
//
//  Created by jack on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Robot;


/**
 * contains all the Robot instances
 * renders robots on the screen
 * handles various events related to robots
 */
@interface Robots : NSObject
{
    /** robots in the order as the RobotColor enum: red, green, blue, yellow */
    NSArray *robots_;
    
    NSArray *initialRobots_;
}


@property (nonatomic, readonly) NSArray *robots;

-(Robot *)selectedRobot;
-(void)selectRobot:(NSInteger)robotColor;

//resets the robots to their initial state
-(void)reset;
-(void)render:(CGContextRef)context;


@end
