//
//  PauseMenu.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "PauseMenu.h"

@implementation PauseMenu
- (id)init
{
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSpriteBatchNode *mainMenuSpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        mainMenuSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        //Add the buttons to the screen
        [self displayPauseMenu];
        
        CCSprite *penguin = [CCSprite spriteWithSpriteFrameName:@"PenguinIdle.png"];
        [penguin setPosition:ccp(screenSize.width * 0.8168f, screenSize.height * 0.215f)];
        
        [mainMenuSpriteBatchNode addChild:penguin];
        
        [self addChild:mainMenuSpriteBatchNode];
        
    }
    
    return self;
}
@end
