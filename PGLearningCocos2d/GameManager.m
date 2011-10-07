//
//  GameManager.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "GameManager.h"
#import "GameScene.h"
//#import "MainMenuScene.h"
//#import "OptionsScene.h"
//#import "CreditsScene.h"
//#import "IntroScene.h"
//#import "LevelCompleteScene.h"

@implementation GameManager
static GameManager* _sharedGameManager = nil;
@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize hasPlayerBeenDefeated;

+(GameManager*)sharedGameManager {
    @synchronized([GameManager class])
    {
        if(!_sharedGameManager)
            [[self alloc] init];
        return _sharedGameManager;
    }
    return nil;
}

+(id)alloc
{
    @synchronized ([GameManager class])
    {
        NSAsser(_sharedGameManager == nil, @"attempted to allocate a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    return nil;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        //Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
        isMusicON = YES;
        isSoundEffectsON = YES;
        hasPlayerBeenDefeated = NO;
        currentScene = kNoSceneUninitialized;
    }
    return self;
}

@end
