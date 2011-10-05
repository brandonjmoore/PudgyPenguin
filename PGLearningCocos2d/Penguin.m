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

//TODO: make sure this was written correctly
-(int)addEatenFish {
    characterFullness++;
    return characterFullness;
}

//TODO: Might need to add the checkAndClampSpritePosition method (pg 94)

//TODO: Add penguin walking method (page 93 dont forget to flip when walking a certain direction)

-(void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    
    //TODO: what are these two variables for?
    id action = nil;
    //TODO: We might be able to use movement action and new position for walking (see pg 97)
    //id movementAction = nil;
    //CGPoint newPosition;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateIdle:
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"penguino_fr.png"]];
            break;
        case kStateWalking:
            action = [CCAnimate actionWithAnimation:penguinWalkingAnim restoreOriginalFrame:YES];
            break;
        case kStateBlinking:
            action = [CCAnimate actionWithAnimation:penguinBlinkingAnim restoreOriginalFrame:YES];
            break;
        case kStateEating:
            action = [CCAnimate actionWithAnimation:penguinEatingAnim restoreOriginalFrame:YES];
            break;
        case kStateAngry:
            action = [CCAnimate actionWithAnimation:penguinAngryAnim restoreOriginalFrame:YES];
            break;
        case kStateSatisfied:
            //restoreOriginalFrame is set to no here because we want him to remain satisfied
            action = [CCAnimate actionWithAnimation:penguinSatisfiedAnim restoreOriginalFrame:NO];
            break;
            
        default:
            CCLOG(@"Unhandled state %d in Penguin", newState);
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}

#pragma mark -
-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    if (self.characterState == kStateSatisfied) 
        return; //Nothing to do if the Penguin is satisfied
    
    //if
    //TODO: finish this method
    
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
