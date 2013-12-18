//
//  RCounter.m
//  Version 0.1
//
//
//  Created by Ans Riaz on 12/12/13.
//  Copyright (c) 2013 Rizh. All rights reserved.
//
//  Have fun :-)

#import "RCounter.h"

#define kCounterDigitStartY 22.0
#define kCounterDigitDiff 23.0

@interface RCounter ()

@end

@implementation RCounter {
    int digits;
    int tagCounterRightToLeft;
    int tagCounterLeftToRight;
}

@synthesize currentReading;

- (void) incrementCounter:(BOOL)animate {
    [self updateCounter:(currentReading + 1) animate:animate];
}

-(void) updateFrame:(UIImageView*)img withValue:(long)newValue andImageCentre:(CGPoint)imgCentre andImageFrame:(CGRect)frame{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:img.center];
    if (newValue == 0) {
        imgCentre.y = centerStart.y - 11 * kCounterDigitDiff;
        anim.toValue = [NSValue valueWithCGPoint:imgCentre];
    } else
        anim.toValue = [NSValue valueWithCGPoint:imgCentre];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.3;
    [img.layer addAnimation:anim forKey:@"rollLeft"];
    img.frame = frame;
}

- (void) updateCounter:(int)newValue animate:(BOOL)animate {

    // Only do something if it is different
    if (newValue == currentReading)
        return;
    
    // Work out the digits
    int hthousandth = (newValue % 1000000)/100000;
    int tenthounsandth = (newValue % 100000) / 10000;
    int thounsandth = (newValue % 10000)/1000;
    int hundredth = (newValue % 1000)/ 100;
    int ten = (newValue % 100) / 10;
    int unit = newValue % 10;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject: [NSNumber numberWithInt:unit]];
    [array addObject: [NSNumber numberWithInt:ten]];
    [array addObject: [NSNumber numberWithInt:hundredth]];
    [array addObject: [NSNumber numberWithInt:thounsandth]];
    [array addObject: [NSNumber numberWithInt:tenthounsandth]];
    [array addObject: [NSNumber numberWithInt:hthousandth]];
    
    for (int i = 0; i < digits; i++) {
        UIImageView *img = (UIImageView*)[self viewWithTag:(tagCounterLeftToRight + i)];
        
        CGRect imgFrame = img.frame;
        CGPoint imgCenter = img.center;
        
        imgFrame.origin.y = kCounterDigitStartY - (([array[i] integerValue] + 1) * kCounterDigitDiff);
        imgCenter.y = centerStart.y - (([array[i] integerValue] + 1) * kCounterDigitDiff);
        
        BOOL imgChanged = NO;
        
        if (imgFrame.origin.y != img.frame.origin.y) {
            imgChanged = YES;
        }
        if (imgChanged) {
            [self updateFrame:img withValue:[array[i] integerValue] andImageCentre:imgCenter andImageFrame:imgFrame];
        }
    }

    currentReading = newValue;
}

#pragma mark - Init/Dealloc

- (id)initWithFrame:(CGRect)frame andNumberOfDigits:(int)_digits
{
    frame.size.width = (_digits * 25) + 10;
    self = [super initWithFrame:frame];
    if (self) {
        
        if (_digits > 6) {
            _digits = 6;
        }
        digits = _digits;
        
        tagCounterRightToLeft = 4025;
        tagCounterLeftToRight = tagCounterRightToLeft + 1 - digits;
        
        // Load the background
        [self setBackgroundColor:[UIColor grayColor]];
        
        // Load the counters
        UIView *counterCanvas = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 160.0, 70.0)];
        
        CGRect frame = CGRectMake(10.0, kCounterDigitStartY, 17.0, 299.0);
        for (int i = 0; i < digits; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
            [img setImage:[UIImage imageNamed:@"counter-numbers.png"]];
            centerStart = img.center;
            
            [img setTag: (tagCounterRightToLeft - i)];
            [counterCanvas addSubview:img];
            frame.origin.x += 25;
        }
        
        [counterCanvas.layer setMasksToBounds:YES];
        [self addSubview:counterCanvas];

        // Add a shadow over top
        UIImageView *shadowOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10 + (digits * 25), 70.0)];
        [shadowOverlay setImage:[UIImage imageNamed:@"counter-shadow.png"]];
        [self addSubview:shadowOverlay];
        [self bringSubviewToFront:shadowOverlay];
        
        // Set the current reading
        currentReading = 000000;
    }
    
    return self;
}

@end
