//
//  EventHandler.h
//  rr
//
//  Created by jack on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


enum EventMove {
    Event_MoveLeft =0,
    Event_MoveUp,
    Event_MoveRight,
    Event_MoveDown,
    
    Event_MoveLast
};   


@class Table;


@interface EventHandler : NSObject
{
    NSMutableArray *history_;
}


@property (nonatomic, strong) Table *table;


-(void)handleSelectEvent:(NSInteger)robotColor;
-(void)handleMoveEvent:(NSInteger)event;
-(void)undoLastMove;
-(void)resetRobotPositions;


@end
