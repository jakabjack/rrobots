//
//  NSArray+Utils.h
//  rr
//
//  Created by jack on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (Utils)


-(NSArray *)shuffled;


+(NSArray *)initWithIntArray:(const int *)values length:(int)length;

@end
