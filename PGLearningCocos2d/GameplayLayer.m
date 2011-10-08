//
//  GameplayLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"
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
    
    //The following call ends the level when the required number of fish are eaten or the fish run out
    //TODO: Here I am handling when the penguin is satisfied, but we need to handle when the fish run out (page 191 & 192)
    GameCharacter *tempChar = (GameCharacter*) [sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
    if (([tempChar characterState] == kStateSatisfied) && ([tempChar numberOfRunningActions] == 0)) {
        [[GameManager sharedGameManager] runSceneWithID:kLevelCompleteScene];
    }
}

-(void)createObjectOfType: (GameObjectType)objectType atLocation:(CGPoint)startLocation withZValue:(int)ZValue {
    if (objectType == kPenguinTypeBlack) {
        CCLOG(@"Creating the Penguin");
        Penguin *penguin = [[Penguin alloc] initWithSpriteFrameName:@"PenguinIdle.png"];
        [penguin setPosition:startLocation];
        [sceneSpriteBatchNode addChild:penguin z:ZValue tag:kPenguinSpriteTagValue];
        [penguin release];
    }else if (objectType == kFishType) {
        CCLOG(@"Creating a fish");
        Fish *fish = [[Fish alloc]initWithSpriteFrameName:@"FishIdle.png"];
        [fish setPosition:startLocation];
        [fish changeState:kStateIdle];
        [sceneSpriteBatchNode addChild:fish z:ZValue];
        //TODO: Look into Fish delegate method might have something to do with page 127
        //[fish setDelegate:self];
        [fish release];
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
        
        
        [self createObjectOfType:kPenguinTypeBlack atLocation:ccp(screenSize.width * 0.35f,screenSize.height * 0.14f) withZValue:kPenguinZValue];
        
        [self scheduleUpdate];
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
    }
    
    return self;
}

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    Penguin *penguin = (Penguin*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
    if (penguin != nil) {
        if (penguin.characterState != kStateSatisfied) {
            [self createObjectOfType:kFishType atLocation:ccp(screenSize.width * 0.195f, screenSize.height * 0.1432f) withZValue:kFishZValue];
        }else {
            //If the Penguin is satisfied, dont create fish
            [self unschedule:@selector(addFish)];
        }
    }    
}



@end
