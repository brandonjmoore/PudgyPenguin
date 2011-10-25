//
//  GameManager.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "GameManager.h"
#import "MainMenuScene.h"
//#import "OptionsScene.h"
//#import "CreditsScene.h"
#import "IntroScene.h"
#import "LevelCompleteScene.h"
//#import "PhysicsLayer.h"
#import "Level1Scene.h"
#import "Level2Scene.h"
#import "Level3Scene.h"
#import "Level4Scene.h"
#import "Level5Scene.h"
#import "Level6Scene.h"
#import "Level7Scene.h"
#import "Level8Scene.h"
#import "Level9Scene.h"
#import "Level11Scene.h"
#import "Level12Scene.h"

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
            sceneToRun = [MainMenuScene node];
            break;
        case kOptionsScene:
            //TODO: sceneToRun = [OptionsScene node];
            break;
        case kCreditsScene:
            //TODO: sceneToRun = [CreditsScene node];
            break;
        case kIntroScene:
            sceneToRun = [IntroScene node];
            break;
        case kLevelCompleteScene:
            sceneToRun = [LevelCompleteScene node];
            break;
        case kGameLevel1:
            sceneToRun = [Level1Scene node];
            break;
        case kGameLevel2:
            sceneToRun = [Level2Scene node];
            break;
        case kGameLevel3:
            sceneToRun = [Level3Scene node];
            break;
        case kGameLevel4:
            sceneToRun = [Level4Scene node];
            break;
        case kGameLevel5:
            sceneToRun = [Level5Scene node];
            break;
        case kGameLevel6:
            sceneToRun = [Level6Scene node];
            break;
        case kGameLevel7:
            sceneToRun = [Level7Scene node];
            break;
        case kGameLevel8:
            sceneToRun = [Level8Scene node];
            break;
        case kGameLevel9:
            sceneToRun = [Level9Scene node];
            break;
        case kGameLevel10:
            //sceneToRun = [Level10Scene node];
            break;
        case kGameLevel11:
            sceneToRun = [Level11Scene node];
            break;
        case kGameLevel12:
            sceneToRun = [Level12Scene node];
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

-(SceneTypes)getCurrentScene {
    return currentScene;
}

-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen{
    //Complete to visit webpages (Page 178)
}

@end
