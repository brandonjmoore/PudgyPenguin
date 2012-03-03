//
//  ActionLayer.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/22/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "ActionLayer.h"
#import "Box2DSprite.h"
#import "Penguin2.h"
#import "Fish2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"
#import "UILayer.h"

@implementation ActionLayer 

-(void) dealloc {
    CCLOG(@"ActionLayer Super dealloc");
    [lineArray release];
    [lineSpriteArray release];
    
    //releases all arrays inside. A leak occurrs if the inside arrays have a retain count higher than 1 prior to this line.
    [lineArrayMaster release];
    [lineSpriteArrayMaster release];
    
    
    [super dealloc];
}


#pragma mark -
#pragma mark Box2d Stuffs
- (void)setupWorld {
    b2Vec2 gravity = b2Vec2(0.0f, -10.0f);
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
    self.isAccelerometerEnabled = TRUE;
}

- (void)setupDebugDraw {
    debugDraw = new GLESDebugDraw(PTM_RATIO*[[CCDirector sharedDirector] contentScaleFactor]);
    world->SetDebugDraw(debugDraw);
    debugDraw->SetFlags(b2DebugDraw::e_shapeBit);
}

#pragma mark -
#pragma mark Create Characters

-(void)createPenguin2AtLocation:(CGPoint)location {
    penguin2 = [[[Penguin2 alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:penguin2 z:1 tag:kPenguinSpriteTagValue];
}

-(void)createFish2AtLocation:(CGPoint)location {
    fish2 = [[[Fish2 alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:fish2 z:1 tag:111];
}

-(id)createBoxAtLocation:(CGPoint)location ofType:(BoxType)boxType {
    box = [[[Box alloc]initWithWorld:world atLocation:location ofType:boxType]autorelease];
    [sceneSpriteBatchNode addChild:box z:1];
    return box;
}

-(b2Body*)createMovingBoxAtLocation:(CGPoint)location ofType:(MovingBoxType)movingBoxType withRotation:(float)rotation{
    b2Body *body = [[MovingBox alloc]initWithWorld:world atLocation:location ofType:movingBoxType withRotation:rotation];
    if (body->GetUserData() != NULL) {
        CCSprite *Data = (CCSprite *)body->GetUserData();
        [sceneSpriteBatchNode addChild:Data z:1];
    }
    return body;
    //[body autorelease];
}

-(void)createTrashAtLocation:(CGPoint)location {
    trash = [[[Trash alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:trash z:1];
}

-(void)createPlatformAtLocation:(CGPoint)location ofType:(PlatformType)platformType withRotation:(float) rotation {
    platform = [[[Platform alloc]initWithWorld:world atLocation:location ofType:platformType withRotation:rotation]autorelease];
    [sceneSpriteBatchNode addChild:platform z:1];
}

-(void)addFish {
    CCLOG(@"ActionLayer->addFish method should be overridden");   
}

-(void)addTrash {
    CCLOG(@"ActionLayer->addTrash method should be overridden");
}

#pragma mark -
#pragma mark Menus

-(void) createPauseButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *pauseButtonNormal = [CCSprite spriteWithSpriteFrameName:@"pause.png"];
    CCSprite *pauseButtonSelected = [CCSprite spriteWithSpriteFrameName:@"pause_over.png"];
    
    pauseButton = [CCMenuItemSprite itemFromNormalSprite:pauseButtonNormal selectedSprite:pauseButtonSelected disabledSprite:nil target:self selector:@selector(doPause)];
    
    pauseButtonMenu = [CCMenu menuWithItems:pauseButton, nil];
    
    [pauseButtonMenu setPosition:ccp(winSize.width * 0.06f, winSize.height * 0.96f)];
    
    [self addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
}

-(void) createClearButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *clearButtonNormal = [CCSprite spriteWithSpriteFrameName:@"clear.png"];
    CCSprite *clearButtonSelected = [CCSprite spriteWithSpriteFrameName:@"clear_over.png"];
    
    clearButton = [CCMenuItemSprite itemFromNormalSprite:clearButtonNormal selectedSprite:clearButtonSelected disabledSprite:nil target:self selector:@selector(clearLines)];
    
    clearButtonMenu = [CCMenu menuWithItems:clearButton, nil];
    
    [clearButtonMenu setPosition:ccp(winSize.width * 0.94f, winSize.height * 0.96f)];
    
    [self addChild:clearButtonMenu z:10 tag:kButtonTagValue];
}

#pragma mark -
#pragma mark Line Drawing

- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event {
    
    CGPoint pt = [self convertTouchToNodeSpace:touch];
	_lastPt = pt;
    
    // create the streak object and add it to the scene
    streak = [CCMotionStreak streakWithFade:200 minSeg:10 image:@"Start.png" width:5 length:20 color:ccc4(255,255,255,255)];
    [self addChild:streak];
    [lineSpriteArray addObject:streak];
    
	return YES;
}


- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
    
    end = [touch previousLocationInView:[touch view]];
    end = [[CCDirector sharedDirector] convertToGL:end];
    
    //This code will draw the line above the user's finger, but it doesnt feel right
//    end.y = end.y + 25;
    
    float distance = ccpDistance(_lastPt, end);
    
    [streak setPosition:end];
    
    if (distance > 10) {
        
        
        b2Vec2 s(_lastPt.x/PTM_RATIO, _lastPt.y/PTM_RATIO);
        b2Vec2 e(end.x/PTM_RATIO, end.y/PTM_RATIO);
        
        b2BodyDef bd;
        
        bd.type = b2_staticBody;
        bd.position.Set(0, 0);
        b2Body* body = world->CreateBody(&bd);
        [lineArray addObject:[NSValue valueWithPointer:body]];
        
        
        b2PolygonShape shape;
        shape.SetAsEdge(b2Vec2(s.x, s.y), b2Vec2(e.x, e.y));
        body->CreateFixture(&shape, 0.0f);
        
        _lastPt = end;
        
        
    }
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    NSArray *newBodyArray = [lineArray copy];//+1 to the retain count of newBodyArray
    NSArray *newSpriteArray = [lineSpriteArray copy];//+1 to the retain count of newSpriteArray
    
    [lineArrayMaster addObject:newBodyArray];//+1 to the retain count of newBodyArray
    [lineSpriteArrayMaster addObject:newSpriteArray];//+1 to the retain count of newSpriteArray
    
    //clear out all the lines so new lines can be added
    [lineSpriteArray removeAllObjects];
    [lineArray removeAllObjects];
    
    //Release these 2 arrays as they will be released when their respective master arrays get released (lineArrayMaster and lineSpriteMasterArray)
    [newBodyArray release];//-1 to the retain count     (currently at 1)
    [newSpriteArray release];//-1 to the retain count   (currently at 1)
}

-(void) clearLines {
    
    
    if ([lineArrayMaster count] > 0) {
        for (NSValue *bodyPtr in [lineArrayMaster lastObject]) {
            b2Body *body = (b2Body*)[bodyPtr pointerValue];
            world->DestroyBody(body);
            
        }
        [lineArrayMaster removeLastObject];//releases the last object in the array and removes it
        
        for (streak in [lineSpriteArrayMaster lastObject]) {
            [streak setVisible:NO];
            [streak removeFromParentAndCleanup:YES];
        }
        [lineSpriteArrayMaster removeLastObject];//releases the last object in the array and removes it
    }
    
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

#pragma mark -
#pragma mark Pause Stuff

-(void) doResume {
    self.isTouchEnabled = YES;
    clearButton.isEnabled = YES;
    pauseButton.isEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [self removeChild:pauseLayer cleanup:YES];
}

-(void) doReturnToMainMenu {
    self.isTouchEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

-(void) doResetLevel {
    CCLOG(@"ActionLayer->doResetLevel method should be overridden");
}

-(void) doNextLevel {
    CCLOG(@"ActionLayer->doNextLevel method should be overridden");
}

-(void)doPause {
    
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    [[CCDirector sharedDirector] pause];
    
    pauseLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:pauseLayer z:9];
    
    CCSprite *pauseText = [CCSprite spriteWithSpriteFrameName:@"paused_text.png"];
    [pauseText setPosition:ccp(screenSize.width *0.5f, screenSize.height * 0.85f)];
    
    CCSprite *resumeButtonNormal = [CCSprite spriteWithSpriteFrameName:@"resume.png"];
    CCSprite *resumeButtonSelected = [CCSprite spriteWithSpriteFrameName:@"resume_over.png"];
    
    CCMenuItemSprite *resumeButton = [CCMenuItemSprite itemFromNormalSprite:resumeButtonNormal selectedSprite:resumeButtonSelected disabledSprite:nil target:self selector:@selector(doResume)];
    
    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
    
    pauseButtonMenu = [CCMenu menuWithItems:resumeButton, resetButton, mainMenuButton, nil];
    
    [pauseButtonMenu alignItemsVerticallyWithPadding:screenSize.height * 0.04f];
    [pauseButtonMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.5f)];
    
    [pauseLayer addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
    [pauseLayer addChild:pauseText];
    self.isTouchEnabled = NO;
    
    
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCLOG(@"ActionLayer->setupBackground method should be overridden");
}

-(void)doHighScoreStuff {
    CCLOG(@"ActionLayer->doHighScoreStuff method should be overridden");
}

-(void) gameOverPass: (id)sender {
    
    CCLOG(@"ActionLayer->gameOverPass method should be overridden");
    
}

-(void) gameOverFail: (id)sender {
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    self.isTouchEnabled = NO;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayerColor *levelCompleteLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:levelCompleteLayer z:9];
    
    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
    
    CCMenu *nextLevelMenu = [CCMenu menuWithItems:resetButton, mainMenuButton, nil];
    [nextLevelMenu alignItemsVerticallyWithPadding:winSize.height * 0.04f];
    [nextLevelMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
    [self addChild:nextLevelMenu z:10];
}

-(id)initWithLevel1UILayer:(UILayer *)UILayer {
    CCLOG(@"ActionLayer->initWithLevel*Layer method should be overridden");
    return nil;
}

-(void)update:(ccTime)dt {
    
    int32 velocityIterations = 3;
    int32 positionIterations = 2;
    
    world->Step(dt, velocityIterations, positionIterations);
    
    for(b2Body *b=world->GetBodyList(); b!=NULL; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            
            //Update sprite position //works but only in one constant direction
            Box2DSprite *sprite = (Box2DSprite *) b->GetUserData();
            sprite.position = ccp(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
            sprite.rotation = CC_RADIANS_TO_DEGREES(b->GetAngle() * -1);
            
            
            //b.position
            
            
            
            
            //update sprite position
            ///////////////////////////added//////////////////////
//            CCSprite *newSprite = (CCSprite *)b->GetUserData();
//            
//            b2Vec2 b2Position = b2Vec2(newSprite.position.x/PTM_RATIO,
//                                       newSprite.position.y/PTM_RATIO);
//            float32 b2Angle = -1 * CC_DEGREES_TO_RADIANS(newSprite.rotation);
//            
//            b->SetTransform(b2Position, b2Angle);
            
        }
    }
    
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    for (GameCharacter *tempChar in listOfGameObjects) {
        [tempChar updateStateWithDeltaTime:dt andListOfGameObjects:listOfGameObjects];
    }
    
    if (penguin2 != nil) {
        if (!gameOver){
            NSString *numFishText = [NSString stringWithFormat:@"%d/5", penguin2.numFishEaten];
            [uiLayer displayNumFish:numFishText];
            
            //Change this so that if he is angry, you can still win the game
            //if (penguin2.characterState == kStateSatisfied) {
            if (penguin2.numFishEaten >= kNumOfFishReq) {
                if (remainingTime == 1) {
                    gameOver = true;
                    CCSprite *gameOverText = [CCLabelTTF labelWithString:@"Buzzer Beater!!!" fontName:@"Marker Felt" fontSize:48];
                    [gameOverText setTag:kBuzzerBeaterSpriteTag];
                    [uiLayer displayText:gameOverText andOnCompleteCallTarget:self selector:@selector(gameOverPass:)];
                } else {
                    gameOver = true;
                    CCSprite *gameOverText = [CCSprite spriteWithSpriteFrameName:@"Passed.png"];
                    [uiLayer displayText:gameOverText andOnCompleteCallTarget:self selector:@selector(gameOverPass:)];
                }
            } else {
                if (remainingTime <= 0) {
                    //Needed so that penguin doesnt dance after time expires
                    penguin2.hasTimeExpired = YES;
                    gameOver = true;
                    CCSprite *gameOverText = [CCSprite spriteWithSpriteFrameName:@"Failed.png"];
                    [uiLayer displayText:gameOverText andOnCompleteCallTarget:self selector:@selector(gameOverFail:)];
                }
            }
        }
    }
    
}



-(void) draw {
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    if (world) {
        world->DrawDebugData();
    }
    
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
}


-(void)updateTime {
    
    if (!gameOver){
        remainingTime = remainingTime - 1.0;
        [uiLayer displaySecs:remainingTime];
    }
    CCLOG(@"-----------%f", remainingTime);
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    b2Vec2 oldGravity = world->GetGravity();
    b2Vec2 gravity(acceleration.x * kAccelerometerMultiplier, oldGravity.y);
    world->SetGravity(gravity);
}

- (void)onExit {
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

@end
