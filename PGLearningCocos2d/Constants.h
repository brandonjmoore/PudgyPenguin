//
//  Constants.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef PGLearningCocos2d_Constants_h
#define PGLearningCocos2d_Constants_h

#define kNumFishCreated             10
#define kPenguinSpriteTagValue      0
#define kPenguinZValue              100
//Idle time is used for idle actions (blinking, yawning, etc.)
#define kPenguinBlinkTime           5.0f
#define kPenguinAngryTime           5.0f

#define kFishZValue                 5
#define kFishIdleTime               10.0f

#define kTimeBetweenFishCreation    2.0f



//GameManager constants (Chapter 7)
#define kMainMenuTag                10
#define kSceneMenuTagValue          20

typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kOptionsScene=2,
    kCreditsScene=3,
    kIntroScene=4,
    kLevelCompleteScene=5,
    kGameLevel1=101,
    kGameLevel2=102,
    kGameLevel3=103,
    kGameLevel4=104,
    kGameLevel5=105,
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

#endif
