//
//  NSArray+Utils.m
//  rr
//
//  Created by jack on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Utils.h"


@implementation NSArray (Utils)


-(NSArray *)shuffled
{
    NSMutableArray *shuffled = [NSMutableArray arrayWithCapacity:self.count];
    
    for(id anObject in self) {
        int pos = arc4random() % (shuffled.count+1);
        [shuffled insertObject:anObject atIndex:pos];
    }
    
    return [NSArray arrayWithArray:shuffled];
}


+(NSArray *)initWithIntArray:(const int *)values length:(int)length
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:length];
    for(int i=0; i<length; i++) {
        [array addObject:[NSNumber numberWithInt:values[i]] ];
    }
    
    return [NSArray arrayWithArray:array];
}


@end
