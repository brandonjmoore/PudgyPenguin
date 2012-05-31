//
//  MyColorLayer.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 4/5/12.
//  Copyright (c) 2012 Vaux, Inc. All rights reserved.
//

#import "MyColorLayer.h"

@implementation MyColorLayer

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (CGRect)rect
{
    CGSize s = [self contentSize];
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
    return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event {
    if ( ![self containsTouchLocation:touch] ) return NO;
    
    return YES;
}


- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

@end
