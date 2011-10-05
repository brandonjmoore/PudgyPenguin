//
//  GameCharacter.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter
@synthesize characterFullness;
@synthesize characterState;

-(void) dealloc {
    [super dealloc];
}

//TODO: Change these methods page 81
-(int)addEatenFish{
    //default to zero fish
    CCLOG(@"addEatenFish should be overridden");
    return 0;
}

-(void)checkAndClampSpritePosition {
    CGPoint currentSpritePosition = [self position];
    
    if (currentSpritePosition.x < 24.0f) {
        [self setPosition:ccp(24.0f, currentSpritePosition.y)];
    } else if (currentSpritePosition.x > 456.0f) {
        [self setPosition:ccp(456.0f, currentSpritePosition.y)];
    }
}

@end
