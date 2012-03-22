//
//  Constants.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 Vaux. All rights reserved.
//
#import "math.h"

#ifndef PGLearningCocos2d_Constants_h
#define PGLearningCocos2d_Constants_h

#pragma mark -
#pragma mark Penguin Constants

#define kPenguinSpriteTagValue      0
#define kPenguinZValue              100
//Idle time is used for idle actions (blinking, yawning, etc.)
#define kPenguinBlinkTime           5.0f
#define kPenguinAngryTime           5.0f
#define kPenguinMouthOpenTime       2.0f
#define kPenguinDanceNumber         5

#pragma mark -
#pragma mark Fish Constants

#define kFishZValue                 5
#define kFishIdleTime               10.0f
#define kTimeBetweenFishCreation    2.0f
#define kTimeBetweenTrashCreation   5.0f
#define kNumOfFishReq               5

#pragma mark -
#pragma mark Game Manager Constants

#define kButtonTagValue             1
#define kIntroMenuTagValue          10
#define kSceneMenuTagValue          20
#define kBackButtonMenuTagValue     20
#define kAccelerometerMultiplier    1
#define kBuzzerBeaterSpriteTag      88

#pragma mark -
#pragma mark Level Constants

#define kLevel1                     1
#define kLevel2                     2
#define kLevel3                     3
#define kLevel4                     4
#define kLevel5                     5
#define kLevel6                     6
#define kLevel7                     7
#define kLevel8                     8
#define kLevel9                     9
#define kLevel10                    10
#define kLevel11                    11
#define kLevel12                    12
#define kLevel13                    13
#define kLevel14                    14
#define kLevel15                    15
#define kLevel16                    16

#pragma mark -
#pragma mark Z Values

#define kZeroZValue                 0
#define kOneZValue                  1
#define kTwoZValue                  2
#define kThreeZValue                3

#pragma mark -
#pragma mark Scene Enumerations

typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kMoreInfoScene=2,
    kCreditsScene=3,
    kIntroScene=4,
    kHighScoresScene=5,
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
    kGameLevel13=113,
    kGameLevel14=114,
    kGameLevel15=115,
    kGameLevel16=116
} SceneTypes;

#pragma mark -
#pragma mark Link Enumerations

typedef enum {
    kLinkTypeBYUMobileApp,
    kLinkTypeCocos2d,
    kLinkTypeBox2D
} LinkTypes;

#pragma mark -
#pragma mark Audio Enumerations

typedef enum {
    kAudioManagerUninitialized=0,
    kAudioManagerFailed=1,
    kAudioManagerInitializing=2,
    kAudioManagerInitialized=100,
    kAudioManagerLoading=200,
    kAudioManagerReady=300
    
} GameManagerSoundState;

#pragma mark -
#pragma mark Audio Constants

#define SFX_NOTLOADED NO
#define SFX_LOADED YES
// Background Music
// Menu Scenes
#define BACKGROUND_TRACK @"pudgypenguin.mp3"
// Audio Items
#define AUDIO_MAX_WAITTIME 150

#pragma mark -
#pragma mark Line Constants
#define kRetinaLineWidth            10
#define kRetinaLineLength           40
#define kLineWidth                  5
#define kLineLength                 20

#pragma mark -
#pragma mark Misc

//Debug Enemy States with Labels
// 0 for OFF, 1 for ON
#define ENEMY_STATE_DEBUG           0
//Box2d ratio convert meters to points
#define PTM_RATIO                   21
#define DEG_TO_RAD(degree)          (degree/M_PI*180)
#define RAD_TO_DEG(radians)         (radians*180/M_PI)
#define kFacebookAppID              @"385665668110717"

#endif
