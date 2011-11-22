//
//  Level13ActionLayer.h
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
#import "Platform.h"
#import "Trash.h"
#import "AppDelegate.h"



@class Level13UILayer;
@class Penguin2;
@class Fish2;

@interface Level13ActionLayer : CCLayer {
    //Characters
    Penguin2 *penguin2;
    Fish2 *fish2;
    Box *box;
    Trash *trash;
    Platform *platform;
    
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
    NSMutableArray *lineArrayMaster;
    NSMutableArray *lineSpriteArrayMaster;
    CCMotionStreak *streak;
    
    
    b2World *world;
    GLESDebugDraw *debugDraw;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    Level13UILayer *uiLayer;
    bool gameOver;
    int numFishCreated;
    int numFishLeftScene;
    double startTime;
    double currentMediaTime;
    double remainingTime;
    int totalScore;
}

-(id)initWithLevel13UILayer:(Level13UILayer *)level13UILayer;
        
@end
