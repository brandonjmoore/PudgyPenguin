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
    //Characters
    Penguin2 *penguin2;
    Fish2 *fish2;
    Box *box;
    Trash *trash;
    
    //Menus
    CCMenu *pauseButtonMenu;
    CCMenu *clearButtonMenu;
    CCLayerColor *pauseLayer;
    CCMenuItemSprite *pauseButton;
    CCMenuItemSprite *clearButton;
    
    
    //Drawing
    CGPoint _lastPt;//Must be declared to handle drawing a line
    CGPoint end;
    NSMutableArray *lineArray;
    NSMutableArray *lineSpriteArray;
    CCMotionStreak *streak;
    
    
    b2World *world;
    GLESDebugDraw *debugDraw;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    Level2UILayer *uiLayer;
    bool gameOver;
    int numFishCreated;
    int numFishLeftScene;
    double startTime;
}

-(id)initWithLevel2UILayer:(Level2UILayer *)level1UILayer;
        
@end
