//
//  Level2ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Constants.h"
#import "Box2DSprite.h"
#import "Box.h"
#import "Trash.h"

@class Level2UILayer;
@class Penguin2;
@class Fish2;

@interface Level2ActionLayer : CCLayer {
    b2World *world;
    GLESDebugDraw *debugDraw;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    b2Body *groundBody;
    Penguin2 *penguin2;
    Fish2 *fish2;
    Level2UILayer *uiLayer;
    CGPoint _lastPt;//Must be declared to handle drawing a line
    bool gameOver;
    Box *box;
    Trash *trash;
    CCMenu *pauseButtonMenu;
    CCLayerColor *pauseLayer;
}

-(id)initWithLevel2UILayer:(Level2UILayer *)level1UILayer;
        
@end
