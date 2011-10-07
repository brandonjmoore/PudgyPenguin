//
//  Fish.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Fish.h"

@implementation Fish
@synthesize fishBlinkingAnim;
@synthesize becomeScaredAnim;
-(void)dealloc {
    //TODO: Be sure to release animations here
    [fishBlinkingAnim release];
    [super dealloc];
}


-(void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    //All animations are commented out because currently there are no fish animations, however is such was to be implemented, the following is how it would be done.
    switch (newState) {
        case kStateIdle:
            CCLOG(@"Fish->Changing State to Idle");
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"FishIdle.png"]];
            break;
            
        case kStateAboutToBeEaten:
            CCLOG(@"Fish->Changing State to aboutToBeEaten");
            //action  = [CCAnimate actionWithAnimation:becomeScared restoreOriginalFrame:NO];
            break;
        
        case kStateHasBeenEaten:
            CCLOG(@"Fish->Changing State to hasBeenEaten");
            break;
            
        default:
            CCLOG(@"Unhandled state %d in Fish", newState);
            break;
    }
    //Run the animation
    if (action != nil) {
        [self runAction:action];
    }
}

//This method was inherited from GameCharacter
-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    if (characterState == kStateHasBeenEaten)
        return;
    
//    penguinCharacter = (GameCharacter*)[[self parent]getChildByTag:kPenguinSpriteTagValue];
//    
//    CGRect penguinBoundingBox = [penguinCharacter adjustedBoundingBox];
//    //The book had the following line to determine if the viking was attacking
//    //CharacterStates penguinState = [penguinCharacter characterState];
//    
//    //Calculate if the penguin is nearby
//    if (CGRectIntersectsRect([self adjustedBoundingBox], penguinBoundingBox)) {
//        if (characterState != kStateAboutToBeEaten) {
//            //If fish is NOT already scared
//            [self changeState:kStateAboutToBeEaten];
//            return;
//        }
//    }
    
    if (([self numberOfRunningActions] == 0) && (characterState != kStateHasBeenEaten) && (characterState != kStateIdle)) {
        CCLOG(@"Going to Idle");
        [self changeState:kStateIdle];
        return;
    }
    
}

-(void)initAnimations {
    [self setFishBlinkingAnim:[self loadPlistForAnimationWithName:@"blinkingAnim" andClassName:NSStringFromClass([self class])]];
    [self setBecomeScaredAnim:[self loadPlistForAnimationWithName:@"becomeScaredAnim" andClassName:NSStringFromClass([self class])]];
}

-(id) init {
    if ((self=[super init])) {
        CCLOG(@"### Fish initialized");
        [self initAnimations];
        gameObjectType = kFishType;
        [self changeState:kStateIdle];
    }
    return self;
}

@end
