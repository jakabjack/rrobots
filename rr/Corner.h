//
//  Corner.h
//  rr
//
//  Created by jack on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPoint.h"


enum Flag {
    TopOn = 1 << 0,
    RightOn = 1 << 1,
    BottomOn = 1 << 2,
    LeftOn = 1 << 3
};


//the above flags in an array
extern const int flags[];
extern const int numFlags;


/**
 * A corner is a maximum of two edges put together perpendicularly
 */
@interface Corner : NSObject
{
    int type_; /* bitwise or-ed Flag-s */
}


@property (nonatomic, readonly) NSInteger type;
/** the corner's coordinates as in table coords */
@property (nonatomic, assign) MyPoint coord;


-(id)initWithType:(int)type;
-(id)initWithType:(int)type coord:(MyPoint)coord;

//the points of the corner in extended table
-(NSArray *)extendedPoints;


//corners to place on table
+(NSArray *)toPlaceCorners;


+(Corner *)cornerWithType:(int)type coord:(MyPoint)coord;



@end
