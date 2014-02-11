//
//  TableBackground.h
//  rr
//
//  Created by jack on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * draws the squares in the background
 */
@interface TableBackground : NSObject
{
    CGContextRef context_;
}


-(id)initWithContext:(CGContextRef)context;

-(void)draw;


@end
