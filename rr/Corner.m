//
//  Corner.m
//  rr
//
//  Created by jack on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Corner.h"
#import "MyPoint.h"


const int flags[] = {TopOn, RightOn, BottomOn, LeftOn};
const int numFlags=sizeof(flags)/sizeof(int);


static const int cornerTypes[] =  {
    LeftOn | TopOn,     // |``
    TopOn | RightOn,    // ``|
    RightOn | BottomOn, //  _|
    BottomOn | LeftOn   // |_
};
static const int numCornerTypes = sizeof(cornerTypes)/sizeof(int);


static MyPoint flagToExtendedPointOffsetMap[] = {
    {0, -1}, //TopOn
    {1, 0},  //RightOn
    {0, 1}, //BottomOn
    {-1, 0}   //LeftOn
};


enum CornerType {
    CornerType_UpperLeft = LeftOn | TopOn,     // |``
    CornerType_UpperRight = TopOn | RightOn,    // ``|
    CornerType_LowerRight = RightOn | BottomOn, //  _|
    CornerType_LowerLeft = BottomOn | LeftOn   // |_
};


//4 pieces for each type + 1 random = 17
static const int corners[] = {
    CornerType_UpperLeft, CornerType_UpperLeft, CornerType_UpperLeft, CornerType_UpperLeft,
    CornerType_UpperRight, CornerType_UpperRight, CornerType_UpperRight, CornerType_UpperRight,
    CornerType_LowerRight, CornerType_LowerRight, CornerType_LowerRight, CornerType_LowerRight,
    CornerType_LowerLeft, CornerType_LowerLeft, CornerType_LowerLeft, CornerType_LowerLeft,
    0 //random
};
static const int numCorners = sizeof(corners)/sizeof(int);
    
  
@implementation Corner


@synthesize coord = coord_;
@synthesize type = type_;


-(id)initWithType:(int)type
{
    self = [super init];
    
    if (self) {
        type_ = type;
    }
    
    return self;
}


-(id)initWithType:(int)type coord:(MyPoint)coord
{
    self = [super init];
    if (self) {
        type_ = type;
        self.coord = coord;
    }
    return self;
}


-(NSArray *)extendedPoints
{
    NSMutableArray *extendedPoints = [NSMutableArray array];
    
    int ex = 2*self.coord.x +1;
    int ey = 2*self.coord.y +1;
    
    for(int flagIndex=0; flagIndex<numFlags; flagIndex++) {
        if (self.type & flags[flagIndex]) {
            MyPoint *offset = &flagToExtendedPointOffsetMap[flagIndex];
            MyPoint extendedPoint = {ex+offset->x, ey+offset->y};
            
            [extendedPoints addObject:[NSValue value:&extendedPoint withObjCType:@encode(struct MyPoint)] ];
        }
    }
    
    return [NSArray arrayWithArray:extendedPoints];
}


+(NSArray *)toPlaceCorners
{
    NSMutableArray *toPlaceCorners = [NSMutableArray arrayWithCapacity:numCorners];
    
    for(int i=0; i<numCorners-1; i++) {
        Corner *corner = [[Corner alloc] initWithType:corners[i]];
        [toPlaceCorners addObject:corner];
    }
    
    //last one random
    int randomCornerType = cornerTypes[arc4random() % numCornerTypes];
    Corner *corner = [[Corner alloc] initWithType:randomCornerType];
    
    [toPlaceCorners addObject:corner];
    
    return [NSArray arrayWithArray:toPlaceCorners];
}


+(Corner *)cornerWithType:(int)type coord:(MyPoint)coord
{
    return [[Corner alloc] initWithType:type coord:coord];
}



@end
