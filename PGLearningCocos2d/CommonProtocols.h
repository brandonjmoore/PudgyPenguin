//
//  CommonProtocols.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 Vaux. All rights reserved.
//

#ifndef PGLearningCocos2d_CommonProtocols_h
#define PGLearningCocos2d_CommonProtocols_h

//Character States
typedef enum {
    kStateIdle,
    kStateAngry,
    kStateEating,
    kStateWalking,
    kStateSatisfied,
    kStateBeingEaten,
    kStateBreathing,
    kStateSmiling,
    kStateHasBeenEaten,
    kStateAboutToBeEaten,
    kStateBlinking,
    kStateMouthOpen
} CharacterStates;

//Object Types
typedef enum {
    kObjectTypeNone,
    kFishType,
    kPenguinTypeBlack,
    kPenguinTypePink,
    kPenguinTypeGreen,
    kTrashType,
    kLineType,
    kNormalBoxType,
    kBouncyBoxType,
    kBalloonBoxType,
    kPlatformTypeExtraExtraLarge,
    kPlatformTypeExtraLarge,
    kPlatformTypeLarge,
    kPlatformTypeMedium,
    kPlatformTypeSmall
} GameObjectType;

//Box Types
typedef enum {
    kNormalBox,
    kBouncyBox,
    kBalloonBox
} BoxType;

//Platform Types
typedef enum {
    kExtraExtraLargePlatform,
    kExtraLargePlatform,
    kLargePlatform,
    kMediumPlatform,
    kSmallPlatform
} PlatformType;

//Protocol used to create objects
@protocol GameplayLayerDelegate

-(void)createObjectOfType: (GameObjectType)objectType atLocation:(CGPoint)startLocation withZValue:(int)ZValue; 

@end

#endif
