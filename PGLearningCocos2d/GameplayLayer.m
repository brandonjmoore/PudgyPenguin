//
//  GameplayLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"

@implementation GameplayLayer

- (id)init
{
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSpriteBatchNode *chapter2SpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlasz.plist"];
        chapter2SpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlasz.png"];
        
        penguinSprite = [CCSprite spriteWithSpriteFrameName:@"penguino_fr.png"];
        
        [chapter2SpriteBatchNode addChild:penguinSprite];
        
        [self addChild:chapter2SpriteBatchNode];
        
        [penguinSprite setPosition:
         CGPointMake(screenSize.width/2,
                     screenSize.height*0.17f)];
    }
    
    return self;
}

@end
