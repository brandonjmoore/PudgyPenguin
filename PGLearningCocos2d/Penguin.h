//
//  Penguin.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/5/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"

@interface Penguin: GameCharacter {
    CCSpriteFrame *standingFrame;
    
    //Standing, blinking, yawning, and walking
    CCAnimation *penguinBlinkingAnim;
    CCAnimation *penguinWalkingAnim;
    
    //Eating animations
    CCAnimation *penguinEatingAnim;
    CCAnimation *penguinAngryAnim;
    CCAnimation *penguinSatisfiedAnim;
    CCAnimation *penguinOpenMouthAnim;
    
    float millisecondsStayingIdle;
    float millisecondsStayingAngry;
    
    BOOL isFishWithinSight;
    
    GameCharacter *fishCharacter;
    id <GameplayLayerDelegate> delegate;
}

@property (nonatomic,assign)id <GameplayLayerDelegate> delegate;

//Standing
@property (nonatomic,retain) CCAnimation *penguinBlinkingAnim;
@property (nonatomic,retain) CCAnimation *penguinWalkingAnim;
@property (nonatomic,retain) CCAnimation *penguinEatingAnim;
@property (nonatomic,retain) CCAnimation *penguinAngryAnim;
@property (nonatomic,retain) CCAnimation *penguinSatisfiedAnim;
@property (nonatomic,retain) CCAnimation *penguinOpenMouthAnim;

-(void)initAnimations;

@end
