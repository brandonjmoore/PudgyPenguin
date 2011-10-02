//
//  GameScene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

- (id)init
{
    self = [super init];
    if (self != nil) {
        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
        
        [self addChild:backgroundLayer z:0];
        
        GameplayLayer *gameplayLayer = [GameplayLayer node];
        
        [self addChild:gameplayLayer z:5];
    }
    
    return self;
}

@end
