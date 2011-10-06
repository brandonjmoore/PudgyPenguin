//
//  GameplayLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"
#import "Penguin.h"
#import "Fish.h"

@implementation GameplayLayer

-(void)dealloc {
    //TODO: Release buttons here
    
    [super dealloc];
}

#pragma mark -
#pragma mark Update Method
//Calls the update method on all the characters in the scene
-(void) update:(ccTime)deltaTime {
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    for (GameCharacter *tempChar in listOfGameObjects) {
        [tempChar updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects];
    }
}

- (id)init {
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        self.isTouchEnabled = YES;
        
        srandom(time(NULL));
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        
        [self addChild:sceneSpriteBatchNode z:0];
        
        Penguin *penguin = [[Penguin alloc]initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"penguino_fr.png"]];
        [penguin setPosition:ccp(screenSize.width * 0.35f,screenSize.height * 0.14f)];
        [sceneSpriteBatchNode addChild:penguin z:kPenguinZValue tag:kPenguinSpriteTagValue];
        
        
        
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
        
        
        [self createObjectOfType:kPenguinTypeBlack atLocation:ccp(screenSize.width * 0.878f, screenSize.height * 0.13f) withZValue:kPenguinZValue];
        
        [self scheduleUpdate];
        
    }
    
    return self;
}

-(void)createObjectOfType: (GameObjectType)objectType atLocation:(CGPoint)startLocation withZValue:(int)ZValue {
    if (objectType == kPenguinTypeBlack) {
        CCLOG(@"Creating the Penguin");
        Penguin *penguin = [[Penguin alloc] initWithSpriteFrameName:@"penguino_fr.png"];
        [penguin setPosition:startLocation];
        [sceneSpriteBatchNode addChild:penguin z:ZValue];
        [penguin release];
    }
}

@end
