//
//  Penguin.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/5/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Penguin.h"

@implementation Penguin
@synthesize delegate;
//Standing, blinking, walking,
@synthesize penguinBlinkingAnim;
@synthesize penguinWalkingAnim;

//Eating Animations
@synthesize penguinOpenMouthAnim;
@synthesize penguinEatingAnim;
@synthesize penguinAngryAnim;
@synthesize penguinSatisfiedAnim;

-(void) dealloc {
    delegate = nil;
    [penguinBlinkingAnim release];
    [penguinWalkingAnim release];
    [penguinEatingAnim release];
    [penguinAngryAnim release];
    [penguinSatisfiedAnim release];
    [penguinOpenMouthAnim release];
    
    [super dealloc];
}

-(CGRect)eyesightBoundingBox {
    CGRect penguinSightBoundingBox;
    CGRect penguinBoundingBox = [self adjustedBoundingBox];
    penguinSightBoundingBox = CGRectMake(penguinBoundingBox.origin.x, penguinBoundingBox.origin.y, penguinBoundingBox.size.width*2.0f, penguinBoundingBox.size.height);
    return penguinSightBoundingBox;
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
            CCLOG(@"Penguin->Changing State to Idle");
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"penguino_fr.png"]];
            break;
        case kStateWalking:
            CCLOG(@"Penguin->Changing State to Walking");
            action = [CCAnimate actionWithAnimation:penguinWalkingAnim restoreOriginalFrame:YES];
            break;
        case kStateBlinking:
            CCLOG(@"Penguin->Changing State to Blinking");
            action = [CCAnimate actionWithAnimation:penguinBlinkingAnim restoreOriginalFrame:YES];
            break;
        case kStateEating:
            CCLOG(@"Penguin->Changing State to Eating");
            action = [CCAnimate actionWithAnimation:penguinEatingAnim restoreOriginalFrame:YES];
            break;
        case kStateAngry:
            CCLOG(@"Penguin->Changing State to Angry");
            action = [CCAnimate actionWithAnimation:penguinAngryAnim restoreOriginalFrame:YES];
            break;
        case kStateSatisfied:
            CCLOG(@"Penguin->Changing State to Satisfied");
            //restoreOriginalFrame is set to no here because we want him to remain satisfied
            action = [CCAnimate actionWithAnimation:penguinSatisfiedAnim restoreOriginalFrame:NO];
            break;
            
        case kStateMouthOpen:
            CCLOG(@"Penguin->Changing State to MouthOpen");
            //restoreOriginalFrame is set to no here because we want his mouth to remain open
            action = [CCAnimate actionWithAnimation:penguinOpenMouthAnim restoreOriginalFrame:NO];
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
    //TODO: finish this method (pg 100)
    
    if ([self numberOfRunningActions] == 0) {
        if (self.characterState == kStateIdle) {
            millisecondsStayingIdle = millisecondsStayingIdle + deltaTime;
            if (millisecondsStayingIdle > kPenguinIdleTime) {
                [self changeState:kStateBlinking];
            }
        } else if (self.characterState != kStateIdle) {
            millisecondsStayingIdle = 0.0f;
            [self changeState:kStateIdle];
        }
    }
}

#pragma mark -
//TODO: Complete this method to detect when a fish is close;
//-(CGRect)adjustedBoundingBox {
//    
//}

-(void)initAnimations {
    [self setPenguinAngryAnim:[self loadPlistForAnimationWithName:@"penguinAngryAnim" andClassName:NSStringFromClass([self class])]];
    [self setPenguinBlinkingAnim:[self loadPlistForAnimationWithName:@"penguinBlinkingAnim" andClassName:NSStringFromClass([self class])]];
    [self setPenguinOpenMouthAnim:[self loadPlistForAnimationWithName:@"penguinOpenMouthAnim" andClassName:NSStringFromClass([self class])]];
}

- (id)init
{
    if ((self=[super init])) {
        gameObjectType = kPenguinTypeBlack;
        [self initAnimations];
        srandom(time(NULL));
    }
    
    return self;
}

@end
