//
//  GameCharacter.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//The following line was not in the book...
#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface GameCharacter : GameObject {
    int characterFullness;
    CharacterStates characterState;
}

-(void)checkAndClampSpritePosition;
-(int)addEatenFish;

@property (readwrite) int characterFullness;
@property (readwrite) CharacterStates characterState;

@end
