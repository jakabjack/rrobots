//
//  TableBackground.h
//  rr
//
//  Created by jack on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TableBackground : NSObject
{
    CGContextRef context_;
}


-(id)initWithContext:(CGContextRef)context;

-(void)draw;


@end
