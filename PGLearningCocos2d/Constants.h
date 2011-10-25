//
//  Constants.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef PGLearningCocos2d_Constants_h
#define PGLearningCocos2d_Constants_h

#define kNumFishToCreate            10
#define kPenguinSpriteTagValue      0
#define kPenguinZValue              100
//Idle time is used for idle actions (blinking, yawning, etc.)
#define kPenguinBlinkTime           5.0f
#define kPenguinAngryTime           5.0f
#define kPenguinMouthOpenTime       2.0f

#define kFishZValue                 5
#define kFishIdleTime               10.0f

#define kTimeBetweenFishCreation    2.0f
#define kTimeBetweenTrashCreation   10.0f


//GameManager constants (Chapter 7)
#define kButtonTagValue             1
#define kIntroMenuTagValue          10
#define kSceneMenuTagValue          20
#define kBackButtonMenuTagValue          20

#define kLastLevelNumber            105

//Required num of fish
#define kNumOfFishReqLev1           5

typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kMoreInfoScene=2,
    kCreditsScene=3,
    kIntroScene=4,
    kGameLevel1=101,
    kGameLevel2=102,
    kGameLevel3=103,
    kGameLevel4=104,
    kGameLevel5=105,
    kGameLevel6=106,
    kGameLevel7=107,
    kGameLevel8=108,
    kGameLevel9=109,
    kGameLevel10=110,
    kGameLevel11=111,
    kGameLevel12=112,
    kCutSceneForLevel2=201
} SceneTypes;

typedef enum {
    kLinkTypeBYUMobileApp,
    kLinkTypeCocos2d,
    kLinkTypeChipmunk,
    kLinkTypeBookSite
} LinkTypes;

//Debug Enemy States with Labels
// 0 for OFF, 1 for ON
#define ENEMY_STATE_DEBUG           0

//Box2d ration (Page 289)
#define PTM_RATIO                  21

// Audio Items
#define AUDIO_MAX_WAITTIME 150

typedef enum {
    kAudioManagerUninitialized=0,
    kAudioManagerFailed=1,
    kAudioManagerInitializing=2,
    kAudioManagerInitialized=100,
    kAudioManagerLoading=200,
    kAudioManagerReady=300
    
} GameManagerSoundState;

// Audio Constants
#define SFX_NOTLOADED NO
#define SFX_LOADED YES

// Background Music
// Menu Scenes
#define BACKGROUND_TRACK @"pudgypenguin.mp3"

#endif
