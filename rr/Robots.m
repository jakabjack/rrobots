//
//  Robots.m
//  rr
//
//  Created by jack on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Robots.h"
#import "Robot.h"
#import "NSArray+Utils.h"


@implementation Robots


@synthesize robots = robots_;


-(id)init
{
    self = [super init];
    
    if (self) {
        //place robots randomly
        NSMutableArray *robots = [NSMutableArray array];
        for(int i=0; i<RobotColor_Num; i++) {
            Robot *robot = [[Robot alloc] initWithColor:i];
            [robots addObject:robot];
        }
        robots_ = [NSArray arrayWithArray:robots];
        
        //select one
        int selectedRobotIndex = arc4random() % robots.count;
        [self selectRobot:selectedRobotIndex];

        //copy
        NSMutableArray *initialRobots = [NSMutableArray array];
        for(Robot *robot in robots) {
            [initialRobots addObject:[robot copy]];
        }
            
        initialRobots_ = [NSArray arrayWithArray:initialRobots];
    }
    
    return self;
}


#pragma mark -
#pragma mark public


-(void)selectRobot:(NSInteger)robotIndex
{
    assert(robotIndex>=0 && robotIndex<robots_.count);
    for(int i=0; i<robots_.count; i++) {
        [[robots_ objectAtIndex:i] setHighlighted:(i==robotIndex)];
    }
}


-(void)reset
{
    NSMutableArray *robots = [NSMutableArray array];
    for(Robot *robot in initialRobots_) {
        [robots addObject:[robot copy]];
    }
    
    robots_ = [NSArray arrayWithArray:robots];
}


-(void)render:(CGContextRef)context
{
    for(Robot *robot in robots_) {
        [robot render:context];
    }
}


-(Robot *)selectedRobot
{
    for (Robot *robot in self.robots) {
        if (robot.isHighlighted) return robot;
    }
    
    assert(false);
    return nil;
}


@end
