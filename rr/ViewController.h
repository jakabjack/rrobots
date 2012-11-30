//
//  ViewController.h
//  rr
//
//  Created by jack on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EventHandler;
@class Table;


@interface ViewController : UIViewController <UITextViewDelegate>
{
    EventHandler *eventHandler_;
    Table *table_;
}


@property (nonatomic, strong) IBOutlet UITextView *textView;


@end
