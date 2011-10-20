//
//  Penguin.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Box2DSprite.h"

@interface Penguin2 : Box2DSprite {
    b2World *world;
    
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
    float millisecondsWithMouthOpen;
    
    BOOL isFishCloseBy;
    
    int numFishEaten;
}

//Standing
@property (nonatomic,retain) CCAnimation *penguinBlinkingAnim;
@property (nonatomic,retain) CCAnimation *penguinWalkingAnim;
@property (nonatomic,retain) CCAnimation *penguinEatingAnim;
@property (nonatomic,retain) CCAnimation *penguinAngryAnim;
@property (nonatomic,retain) CCAnimation *penguinSatisfiedAnim;
@property (nonatomic,retain) CCAnimation *penguinOpenMouthAnim;

-(void)initAnimations;

- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location;


@end
