//
//  GameManager.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "GameManager.h"
#import "MainMenuScene.h"
#import "MoreInfoScene.h"
#import "CreditsScene.h"
#import "HighScoresScene.h"
#import "IntroScene.h"
#import "LevelSelectScene.h"
#import "Level1Scene.h"
#import "Level2Scene.h"
#import "Level3Scene.h"
#import "Level4Scene.h"
#import "Level5Scene.h"
#import "Level6Scene.h"
#import "Level7Scene.h"
#import "Level8Scene.h"
#import "Level9Scene.h"
#import "Level10Scene.h"
#import "Level11Scene.h"
#import "Level12Scene.h"
#import "Level13Scene.h"
#import "Level14Scene.h"
#import "Level15Scene.h"
#import "Level16Scene.h"
#import "Level17Scene.h"
#import "level18Scene.h"
#import "Level19Scene.h"
#import "Level20Scene.h"
#import "Level21Scene.h"
#import "Level22Scene.h"
#import "Level23Scene.h"
#import "Level24Scene.h"
#import "Level25Scene.h"
#import "Level26Scene.h"
#import "Level27Scene.h"
#import "Level28Scene.h"
#import "Level29Scene.h"
#import "Level30Scene.h"
#import "Level31Scene.h"
#import "Level32Scene.h"
#import "Level33Scene.h"
#import "Level34Scene.h"


@implementation GameManager
static GameManager* _sharedGameManager = nil;
@synthesize isMusicON,isSoundEffectOn;
@synthesize managerSoundState;
@synthesize listOfSoundEffectFiles;
@synthesize soundEffectsState;
@synthesize lastLevelPlayed;

#pragma mark -
#pragma mark Init Methods

+(GameManager*)sharedGameManager {
    @synchronized([GameManager class])
    {
        if(!_sharedGameManager)
            _sharedGameManager = [[self alloc] init];
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

//-(void)loadAudio {
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
//    
//    if (managerSoundState == kAudioManagerInitializing) {
//        int waitCycles = 0;
//        while (waitCycles < AUDIO_MAX_WAITTIME) {
//            [NSThread sleepForTimeInterval:0.1f];
//            if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed)) {
//                break;
//            }
//            waitCycles = waitCycles + 1;
//        }
//    }
//    
//    if (managerSoundState == kAudioManagerFailed) {
//        return;
//    }
//    
//    
//    if ((soundEffectsState == nil) || ([soundEffectsState count] < 1)) {
//        [self setSoundEffectsState:[[NSMutableDictionary alloc]init]];
//        CCLOG(@"Loading audio files");
//        [soundEngine preloadEffect:LEVEL_FAILED_SOUND];
//        [soundEffectsState setObject:[NSNumber numberWithBool:SFX_LOADED ] forKey:LEVEL_FAILED_SOUND];
//    }
//    
//    
//    
//    [pool release];
//    
//}
//
//-(void)playBackgroundTrack:(NSString *)trackFileName {
//    //Wait to make sure soundEngine is initialized
//    if ((managerSoundState != kAudioManagerReady) && (managerSoundState != kAudioManagerFailed)) {
//        int waitCycles = 0;
//        while (waitCycles < AUDIO_MAX_WAITTIME) {
//            [NSThread sleepForTimeInterval:0.1f];
//            if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed)) {
//                break;
//            }
//            waitCycles = waitCycles + 1;
//        }
//    }
//    
//    if (managerSoundState == kAudioManagerReady) {
//        if ([soundEngine isBackgroundMusicPlaying]) {
//            [soundEngine stopBackgroundMusic];
//        }
//        [soundEngine preloadBackgroundMusic:trackFileName];
//        [soundEngine playBackgroundMusic:trackFileName loop:YES];
//    }
//}
//
//-(void)stopSoundEffect:(ALuint)soundEffectID {
//    if (managerSoundState == kAudioManagerReady) {
//        [soundEngine stopEffect:soundEffectID];
//    }
//}
//
//-(ALuint)playSoundEffect:(NSString *)soundEffectKey {
//    ALuint soundID = 0;
//    if (managerSoundState == kAudioManagerReady) {
//        NSNumber *isFXLoaded = [soundEffectsState objectForKey:soundEffectKey];
//        if ([isFXLoaded boolValue] == SFX_LOADED) {
//            soundID = [soundEngine playEffect:soundEffectKey];
//        } else {
//            CCLOG(@"GameManager: Sound Effect %@ is not loaded.",soundEffectKey);
//        }
//    } else {
//        CCLOG(@"GameManager: Sound Manager is not ready, cannot play %@", soundEffectKey);
//    }
//    return soundID;
//}
//
//
//-(void)initAudioAsync {
//    //Initialize the audio engine asynchronously
//    managerSoundState = kAudioManagerInitializing;
//    //Indicate that we are tring to start up the Audio Manager
//    [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_HIGH];
//    
//    //Init the audio manager asynchronously as it can take a few seconds
//    //The FXPlusMusicIfNoOtherAudio mode will check if the user is
//    //playing music and disable background music playback if that is the case
//    [CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];
//    
//    //Wait for the audio manager to initialize
//    while ([CDAudioManager sharedManagerState] != kAMStateInitialised) {
//        [NSThread sleepForTimeInterval:0.1];
//    }
//    
//    //At this point the CocosDenshion should be initialized
//    //Grab the CDAudioManager and check the state
//    CDAudioManager *audioManager = [CDAudioManager sharedManager];
//    if (audioManager.soundEngine == nil || audioManager.soundEngine.functioning == NO) {
//        CCLOG(@"CocosDenshion failed to init, no audio will play");
//        managerSoundState = kAudioManagerFailed;
//    } else {
//        [audioManager setResignBehavior:kAMRBStopPlay autoHandle:YES];
//        soundEngine = [SimpleAudioEngine sharedEngine];
//        managerSoundState = kAudioManagerReady;
//        CCLOG(@"CocosDenshion is Ready");
//    }
//    
//}
//
//-(void)setupAudioEngine {
//    if (hasAudioBeenInitialized == YES) {
//        return;
//    } else {
//        hasAudioBeenInitialized = YES;
//        NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
//        NSInvocationOperation *asyncSetupOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(initAudioAsync) object:nil];
//        [queue addOperation:asyncSetupOperation];
//        [asyncSetupOperation autorelease];
//    }
//}

- (id)init {
    self = [super init];
    if (self != nil) {
        //Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
//        hasAudioBeenInitialized = NO;
//        soundEngine = nil;
//        managerSoundState = kAudioManagerUninitialized;
        
        isMusicON = [[NSUserDefaults standardUserDefaults] boolForKey:@"ismusicon"];
        currentScene = kNoSceneUninitialized;
    }
    return self;
}

#pragma mark -
#pragma mark Run Levels

-(void)runSceneWithID:(SceneTypes)sceneID {
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    switch (sceneID) {
        case kMainMenuScene:
            sceneToRun = [MainMenuScene node];
            break;
        case kLevelSelectScene:
            sceneToRun = [LevelSelectScene node];
            break;
        case kMoreInfoScene:
            sceneToRun = [MoreInfoScene node];
            break;
        case kCreditsScene:
            sceneToRun = [CreditsScene node];
            break;
        case kHighScoresScene:
            sceneToRun = [HighScoresScene node];
            break;
        case kIntroScene:
            sceneToRun = [IntroScene node];
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
            sceneToRun = [Level10Scene node];
            break;
        case kGameLevel11:
            sceneToRun = [Level11Scene node];
            break;
        case kGameLevel12:
            sceneToRun = [Level12Scene node];
            break;
        case kGameLevel13:
            sceneToRun = [Level13Scene node];
            break;
        case kGameLevel14:
            sceneToRun = [Level14Scene node];
            break;
        case kGameLevel15:
            sceneToRun = [Level15Scene node];
            break;
        case kGameLevel16:
            sceneToRun = [Level16Scene node];
            break;
        case kGameLevel17:
            sceneToRun = [Level17Scene node];
            break;
        case kGameLevel18:
            sceneToRun = [Level18Scene node];
            break;
        case kGameLevel19:
            sceneToRun = [Level19Scene node];
            break;
        case kGameLevel20:
            sceneToRun = [Level20Scene node];
            break;
        case kGameLevel21:
            sceneToRun = [Level21Scene node];
            break;
        case kGameLevel22:
            sceneToRun = [Level22Scene node];
            break;
        case kGameLevel23:
            sceneToRun = [Level23Scene node];
            break;
        case kGameLevel24:
            sceneToRun = [Level25Scene node];
            break;
        case kGameLevel25:
            sceneToRun = [Level26Scene node];
            break;
        case kGameLevel26:
            sceneToRun = [Level24Scene node];
            break;
        case kGameLevel27:
            sceneToRun = [Level27Scene node];
            break;
        case kGameLevel28:
            sceneToRun = [Level28Scene node];
            break;
        case kGameLevel29:
            sceneToRun = [Level29Scene node];
            break;
        case kGameLevel30:
            sceneToRun = [Level30Scene node];
            break;
        case kGameLevel31:
            sceneToRun = [Level31Scene node];
            break;
        case kGameLevel32:
            sceneToRun = [Level32Scene node];
            break;
        case kGameLevel33:
            sceneToRun = [Level33Scene node];
            break;
        case kGameLevel34:
            sceneToRun = [Level34Scene node];
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
    
    lastLevelPlayed = sceneID;
    
    //[self performSelectorInBackground:@selector(loadAudio) withObject:nil];
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    } else {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
    
}

-(SceneTypes)getCurrentScene {
    return currentScene;
}

#pragma mark -
#pragma mark Misc Methods

-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen{
    //Future implementation
}

@end
