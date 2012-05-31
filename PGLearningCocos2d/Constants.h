//
//  Constants.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 Vaux. All rights reserved.
//
#import "math.h"
#import "cocos2d.h"

#ifndef PGLearningCocos2d_Constants_h
#define PGLearningCocos2d_Constants_h

#pragma mark -
#pragma mark Penguin Constants



//Idle time is used for idle actions (blinking, yawning, etc.)
#define kPenguinBlinkTime           5.0f
#define kPenguinAngryTime           5.0f
#define kPenguinMouthOpenTime       2.0f
#define kPenguinDanceNumber         5

#pragma mark -
#pragma mark Fish Constants


#define kFishIdleTime               10.0f
#define kTimeBetweenFishCreation    2.0f
#define kTimeBetweenTrashCreation   5.0f
#define kNumOfFishReq               5

#pragma mark -
#pragma mark Sprite Tags
#define kPenguinSpriteTagValue      0
#define kFishSpriteTagValue         1
#define kTrashSpriteTagValue        2
#define kNormalBoxTag               3
#define kBouncyBoxTag               4
#define kBalloonBoxTag              5
#define kPlatformTag                6

#pragma mark -
#pragma mark Z Values

#define kPenguinZValue              1
#define kFishZValue                 2
#define kTrashZValue                2
#define kBoxZValue                  3
#define kPlatformZValue             3

#pragma mark -
#pragma mark Game Manager Constants

#define kButtonTagValue             1
#define kIntroMenuTagValue          10
#define kSceneMenuTagValue          20
#define kBackButtonMenuTagValue     20
#define kAccelerometerMultiplier    1
#define kBuzzerBeaterSpriteTag      88
#define kAchievementUnlockedBuzzerBeater    89
#define kMaxNumBuzzerBeaters        5

#pragma mark -
#pragma mark Level Constants

#define kActionLayer                184
#define kLevelTag                   
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
#define kLevel17                    17
#define kLevel18                    18
#define kLevel19                    19
#define kLevel20                    20
#define kLevel21                    21
#define kLevel22                    22
#define kLevel23                    23
#define kLevel24                    24
#define kLevel25                    25
#define kLevel26                    26
#define kLevel27                    27
#define kLevel28                    28
#define kLevel29                    29
#define kLevel30                    30
#define kLevel31                    31
#define kLevel32                    32
#define kLevel33                    33
#define kLevel34                    34
#define kLevel35                    35
#define kLevel36                    36
#define kLevel37                    37
#define kLevel38                    38
#define kLevel39                    39
#define kLevel40                    40
#define kLevel41                    41
#define kLevel42                    42
#define kLevel43                    43
#define kLevel44                    44
#define kLevel45                    45
#define kLevel46                    46
#define kLevel47                    47
#define kLevel48                    48

#pragma mark -
#pragma mark Z Values

#define kNegThreeValue              -3
#define kNegTwoZValue               -2
#define kNegOneZValue               -1
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
    kLevelSelectScene=6,
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
    kGameLevel16=116,
    kGameLevel17=117,
    kGameLevel18=118,
    kGameLevel19=119,
    kGameLevel20=120,
    kGameLevel21=121,
    kGameLevel22=122,
    kGameLevel23=123,
    kGameLevel24=124,
    kGameLevel25=125,
    kGameLevel26=126,
    kGameLevel27=127,
    kGameLevel28=128,
    kGameLevel29=129,
    kGameLevel30=130,
    kGameLevel31=131,
    kGameLevel32=132,
    kGameLevel33=133,
    kGameLevel34=134,
    kGameLevel35=135,
    kGameLevel36=136,
    kGameLevel37=137,
    kGameLevel38=138,
    kGameLevel39=139,
    kGameLevel40=140,
    kGameLevel41=141,
    kGameLevel42=142,
    kGameLevel43=143,
    kGameLevel44=144,
    kGameLevel45=145,
    kGameLevel46=146,
    kGameLevel47=147,
    kGameLevel48=148
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

#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect:@#__VA_ARGS__]

#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect:@#__VA_ARGS__]


#define BACKGROUND_TRACK_MAIN_MENU @"MainMenuMusic.mp3"
#define BACKGROUND_TRACK_GAMEPLAY @"pudgypenguin.mp3"
#define LEVEL_FAILED_SOUND @"Level Failed.mp3"
#define LEVEL_PASSED_SOUND @"Level Passed.mp3"

// Audio Items
#define AUDIO_MAX_WAITTIME 150

#pragma mark -
#pragma mark Line Constants
#define kRetinaLineWidth            10
#define kRetinaLineLength           40
#define kLineWidth                  5
#define kLineLength                 25

#pragma mark -
#pragma mark Misc

//Debug Enemy States with Labels
// 0 for OFF, 1 for ON
#define ENEMY_STATE_DEBUG           0
//Box2d ratio convert meters to points
#define PTM_RATIO                   ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 41 : 21)
#define kFONT                       ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"51.fnt" : @"24.fnt")
#define DEG_TO_RAD(degree)          (degree/M_PI*180)
#define RAD_TO_DEG(radians)         (radians*180/M_PI)
#define VEL_TO_SEC(distance,velocity)        (distance/(.065*(sqrt(velocity*velocity))))
#define kFacebookAppID              @"385665668110717"
#define ARC4RANDOM_MAX              0x100000000
#define MAX_BOUNCE_ANIM_VELOCITY    5
#define kMoveActionTag              1
#define kBlinkActionTag             2
#define kSatisfiedTag               3


#endif
