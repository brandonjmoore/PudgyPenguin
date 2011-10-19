//
//  Level1ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Constants.h"
#import "Box2DSprite.h"


@class Level1UILayer;
@class Penguin2;
@class Fish2;

@interface Level1ActionLayer : CCLayer {
    b2World *world;
    GLESDebugDraw *debugDraw;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    b2Body *groundBody;
    Penguin2 *penguin2;
    Fish2 *fish2;
    Level1UILayer *uiLayer;
    CGPoint _lastPt;//Must be declared to handle drawing a line
    bool gameOver;
    CCMenu *pauseButtonMenu;
    CCLayerColor *pauseLayer;
}

-(id)initWithLevel1UILayer:(Level1UILayer *)level1UILayer;

@end


