//
//  CommonProtocols.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef PGLearningCocos2d_CommonProtocols_h
#define PGLearningCocos2d_CommonProtocols_h

typedef  enum {
    kDirectionLeft,
    kDirectionRight
} PhaserDirection;

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

typedef enum {
    kObjectTypeNone,
    kFishType,
    kPenguinTypeBlack,
    kPenguinTypePink,
    kPenguinTypeGreen,
    kTrashType,
    kLineType
} GameObjectType;

@protocol GameplayLayerDelegate

-(void)createObjectOfType: (GameObjectType)objectType atLocation:(CGPoint)startLocation withZValue:(int)ZValue; 

@end

#endif
