//
//  ViewController.m
//  RCounterExample
//
//  Created by Ans Riaz on 12/18/13.
//  Copyright (c) 2013 Rizh. All rights reserved.
//


#import "ViewController.h"
#import "RCounter.h"

#define kRefreshTimeInSeconds 1

@interface ViewController () {
    NSTimer *myTimerName;
    long second;
    RCounter *counter;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    counter = [[RCounter alloc] initWithFrame:CGRectMake(0, 0, 160, 70) andNumberOfDigits:3];
    [self.view addSubview:counter];
    counter.center = self.view.center;
    
    second = 0;
    
    myTimerName = [NSTimer scheduledTimerWithTimeInterval: kRefreshTimeInSeconds target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)handleTimer: (id) sender
{
    
    //    [counter updateCounter:second animate:YES];
    [counter incrementCounter:YES];
    //    second++;
}

-(void)stopTimer: (id) sender
{
    if(myTimerName)
    {
        [myTimerName invalidate];
        myTimerName = nil;
    }
}


@end
