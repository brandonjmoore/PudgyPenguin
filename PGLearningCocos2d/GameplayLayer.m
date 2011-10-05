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
        
        CCSpriteBatchNode *mySpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        mySpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        
        penguinSprite = [CCSprite spriteWithSpriteFrameName:@"penguino_fr.png"];
        
        [mySpriteBatchNode addChild:penguinSprite];
        
        [self addChild:mySpriteBatchNode];
        
        [penguinSprite setPosition:
         CGPointMake(screenSize.width/2,
                     screenSize.height*0.17f)];
        
        
        //Handle Animations
        CCAnimation *angryPenguinAnim = [CCAnimation animation];
        
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"penguino_fr.png"]];
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"angryAnim1.png"]];
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"angryAnim2.png"]];
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"angryAnim2.png"]];
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"angryAnim3.png"]];
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"angryAnim3.png"]];
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"angryAnim1.png"]];
        [angryPenguinAnim addFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"penguino_fr.png"]];
        
        id animateAction = [CCAnimate actionWithDuration:1.0f animation:angryPenguinAnim restoreOriginalFrame:YES];
        id repeatAction = [CCRepeatForever actionWithAction:animateAction];
        
        [penguinSprite runAction:repeatAction];
        
        
    }
    
    return self;
}

@end
