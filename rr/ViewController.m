//
//  ViewController.m
//  rr
//
//  Created by jack on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "EventHandler.h"
#import "Table.h"
#import "RRView.h"
#import "Robot.h"


@implementation ViewController


@synthesize textView = textView_;


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        table_ = [[Table alloc] init];
        eventHandler_ = [[EventHandler alloc] init]; 
        eventHandler_.table = table_;
    }
    
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RRView *view = (RRView *)self.view;
    view.table = table_;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.textView.text = @"aaaa";
    self.textView.selectedRange = NSMakeRange(2, 0);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.textView becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSRange range = textView.selectedRange;
    
    if (2==range.location) {
        //do nothing
        
    } else if (1==range.location) {
        [eventHandler_ handleMoveEvent:Event_MoveLeft];
        
    } else if (0==range.location) {
        [eventHandler_ handleMoveEvent:Event_MoveUp];
        
    } else if (3==range.location) {
        [eventHandler_ handleMoveEvent:Event_MoveRight];
        
    } else if (4==range.location) {
        [eventHandler_ handleMoveEvent:Event_MoveDown];
    }

    textView.delegate = nil;
    self.textView.selectedRange = NSMakeRange(2, 0);
    textView.delegate = self;

    [self.view setNeedsDisplay];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"a"]) {
        [eventHandler_ handleSelectEvent:RobotColor_Red];
        
    } else if ([text isEqualToString:@"s"]) {
        [eventHandler_ handleSelectEvent:RobotColor_Green];
        
    } else if ([text isEqualToString:@"d"]) {
        [eventHandler_ handleSelectEvent:RobotColor_Blue];
        
    } else if ([text isEqualToString:@"f"]) {
        [eventHandler_ handleSelectEvent:RobotColor_Yellow];
        
    } else if ([text isEqualToString:@"v"]) {
        [eventHandler_ undoLastMove];
        
    } else if ([text isEqualToString:@" "]) {
        [eventHandler_ resetRobotPositions];
    }

    [self.view setNeedsDisplay];
    
    return NO;
}



@end
