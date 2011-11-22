//
//  Level1ActionLayer.h
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
#import "AppDelegate.h"


@class Level1UILayer;
@class Penguin2;
@class Fish2;

@interface Level1ActionLayer : CCLayer {
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
    NSMutableArray *lineArrayMaster;
    NSMutableArray *lineSpriteArrayMaster;
    CCMotionStreak *streak;
    
    
    b2World *world;
    GLESDebugDraw *debugDraw;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    Level1UILayer *uiLayer;
    bool gameOver;
    int numFishCreated;
    int numFishLeftScene;
    double startTime;
    double currentMediaTime;
    double remainingTime;

}

-(id)initWithLevel1UILayer:(Level1UILayer *)level1UILayer;
        
@end
