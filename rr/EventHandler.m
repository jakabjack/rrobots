//
//  EventHandler.m
//  rr
//
//  Created by jack on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventHandler.h"
#import "Table.h"
#import "Robots.h"
#import "MyPoint.h"
#import "Robot.h"


//debug
static char * eventNames[] = {
    "Event_MoveLeft",
    "Event_MoveUp",
    "Event_MoveRight",
    "Event_MoveBottom"

    "Event_SelectRedRobot",
    "Event_SelectGreenRobot", 
    "Event_SelectBlueRobot",
    "Event_SelectYellowRobot",
};


//x,y offsets for each moving direction from enum EventMove
static MyPoint directionOffsets[] = {
    {-1, 0}, //Event_MoveLeft 
    {0, -1}, //Event_MoveUp,
    {1, 0},  //Event_MoveRight,
    {0, 1}   //Event_MoveDown,
};


@implementation EventHandler


@synthesize table = table_;


-(id)init
{
    self = [super init];
    if (self) {
        history_ = [[NSMutableArray alloc] init];
    }
    
    return self;
}


#pragma mark -
#pragma mark public


-(void)handleSelectEvent:(NSInteger)robotColor
{
    assert(0<=robotColor && robotColor<RobotColor_Num);
    [self.table.robots selectRobot:robotColor];
}


-(void)handleMoveEvent:(NSInteger)event
{
    assert(0<=event && event<Event_MoveLast);
    
    //store in history
    Robot *robotForHistory = [[Robot alloc] initWithColor:self.table.robots.selectedRobot.color];
    robotForHistory.coord = self.table.robots.selectedRobot.coord;
    [history_ addObject:robotForHistory];
    
    MyPoint offset = directionOffsets[event];
    [self.table move:offset];
}


-(void)undoLastMove
{
    if (history_.count==0) return;
    
    Robot *robotFromHistory = [history_ lastObject];
    [history_ removeLastObject];
    
    //make undo
    [self.table.robots selectRobot:robotFromHistory.color];
    [self.table moveAbsolute:robotFromHistory.coord];
}


-(void)resetRobotPositions
{
    [self.table resetRobotPositions];
}


@end
