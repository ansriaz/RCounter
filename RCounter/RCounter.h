//
//  RCounter.h
//  Version 0.1
//
//
//  Created by Ans Riaz on 12/12/13.
//  Copyright (c) 2013 Rizh. All rights reserved.
//
//  Have fun :-)

#import <UIKit/UIKit.h>

@interface RCounter : UIControl {
    
    int currentReading;
    CGPoint centerStart;
}

@property (nonatomic, readonly) int currentReading;

- (void) incrementCounter:(BOOL)animate;
- (void) updateCounter:(int)newValue animate:(BOOL)animate;
- (id)initWithFrame:(CGRect)frame andNumberOfDigits:(int)_digits;

@end
