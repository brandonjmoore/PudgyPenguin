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

@class UILayer;
@class Penguin2;
@class Fish2;

@interface ActionLayer : CCLayer {
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
-(void)createBoxAtLocation:(CGPoint)location ofType:(BoxType)boxType;
-(void)createTrashAtLocation:(CGPoint)location;
-(void)addFish;
-(void)addTrash;
-(void) createPauseButton;
-(void) createClearButton;
//- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event;
//- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event;
//-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
//-(void) clearLines;
//- (void)registerWithTouchDispatcher;
//-(void) doResume;
//-(void) doReturnToMainMenu;
-(void) doResetLevel;
-(void) doNextLevel;
//-(void)doPause;
-(void)setupBackground;
-(void)doHighScoreStuff;
-(void) gameOverPass: (id)sender;
//-(void) gameOverFail: (id)sender;
-(id)initWithLevel1UILayer:(UILayer *)UILayer;
//-(void)update:(ccTime)dt;
//-(void) draw;
//-(void)updateTime;

@end
