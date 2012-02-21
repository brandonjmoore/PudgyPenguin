//
//  ActionLayer.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/22/11.
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
#import "Platform.h"
#import "MovingBox.h"

@class UILayer;
@class Penguin2;
@class Fish2;

@interface ActionLayer : CCLayer {
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
    UILayer *uiLayer;
    bool gameOver;
    int numFishCreated;
    int numFishLeftScene;
    double startTime;
    double currentMediaTime;
    double remainingTime;
    
}

- (void)setupWorld;
- (void)setupDebugDraw;
-(void)createPenguin2AtLocation:(CGPoint)location;
-(void)createFish2AtLocation:(CGPoint)location;
-(id)createBoxAtLocation:(CGPoint)location ofType:(BoxType)boxType;
-(void)createTrashAtLocation:(CGPoint)location;
-(void)createPlatformAtLocation:(CGPoint)location ofType:(PlatformType)platformType withRotation:(float) rotation;
-(void)addFish;
-(void)addTrash;
-(void) createPauseButton;
-(void) createClearButton;



-(b2Body*)createMovingBoxAtLocation:(CGPoint)location ofType:(MovingBoxType)movingBoxType withRotation:(float)rotation;

//-(void) doResetLevel;
//-(void) doNextLevel;
//-(void)setupBackground;
//-(void)doHighScoreStuff;
//-(void) gameOverPass: (id)sender;
////-(id)initWithLevel1UILayer:(UILayer *)UILayer;

@end
