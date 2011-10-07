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
        NSAssert(_sharedGameManager == nil, @"attempted to allocate a second instance of the Game Manager singleton");
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

-(void)runSceneWithID:(SceneTypes)sceneID {
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    switch (sceneID) {
        case kMainMenuScene:
            //TODO: sceneToRun = [MainMenuScene node];
            break;
        case kOptionsScene:
            //TODO: sceneToRun = [OptionsScene node];
            break;
        case kCreditsScene:
            //TODO: sceneToRun = [CreditsScene node];
            break;
        case kIntroScene:
            //TODO: sceneToRun = [IntroScene node];
            break;
        case kLevelCompleteScene:
            //TODO: sceneToRun = [LevelCompleteScene node];
            break;
        case kGameLevel1:
            sceneToRun = [GameScene node];
            break;
            
        case kGameLevel2:
            //Placeholder for Level 2
            break;
        case kGameLevel3:
            //Placeholder for Level 3
            break;
        case kGameLevel4:
            //Placeholder for Level 4
            break;
        case kGameLevel5:
            //Placeholder for Level 5
            break;
        case kCutSceneForLevel2:
            //Placeholder for Platform Level
            break;
        
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if (sceneToRun == nil) {
        //Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    } else {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
    
}

-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen{
    //Complete to visit webpages (Page 178)
}

@end
