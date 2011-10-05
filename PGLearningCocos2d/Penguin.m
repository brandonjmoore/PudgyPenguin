//
//  Penguin.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/5/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Penguin.h"

@implementation Penguin
//Standing, blinking, walking, eating
@synthesize penguinBlinkingAnim;
@synthesize penguinWalkingAnim;

//Eating Animations
@synthesize penguinEatingAnim;
@synthesize penguinAngryAnim;
@synthesize penguinSatisfiedAnim;

-(void) dealloc {
    [penguinBlinkingAnim release];
    [penguinWalkingAnim release];
    [penguinEatingAnim release];
    [penguinAngryAnim release];
    [penguinSatisfiedAnim release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
