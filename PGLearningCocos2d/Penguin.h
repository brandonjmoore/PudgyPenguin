//
//  Penguin.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/5/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"

@interface Penguin : GameCharacter {
    CCSpriteFrame *standingFrame;
    
    //Standing, blinking, yawning, and walking
    CCAnimation *penguinBlinkingAnim;
    CCAnimation *penguinWalkingAnim;
    
    //Eating animations
    CCAnimation *penguinEatingAnim;
    CCAnimation *penguinAngryAnim;
}

@end
