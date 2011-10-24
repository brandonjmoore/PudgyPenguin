//
//  Level2ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level2ActionLayer.h"
#import "Box2DSprite.h"
#import "Level2UILayer.h"
#import "Penguin2.h"
#import "Fish2.h"
#import "GameManager.h"

@implementation Level2ActionLayer

-(void) dealloc {
    CCLOG(@"Level2ActionLayer dealloc");
    [lineArray release];
    [lineSpriteArray release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Box2d Stuffs
- (void)setupWorld {
    b2Vec2 gravity = b2Vec2(0.0f, -10.0f);
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
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

-(void)createBoxAtLocation:(CGPoint)location ofType:(BoxType)boxType{
    box = [[[Box alloc]initWithWorld:world atLocation:location ofType:boxType]autorelease];
    [sceneSpriteBatchNode addChild:box z:1];
}

-(void)createPlatformAtLocation:(CGPoint)location ofType:(PlatformType)platformType withRotation:(float) rotation{
    platform = [[[Platform alloc]initWithWorld:world atLocation:location ofType:platformType withRotation:rotation]autorelease];
    [sceneSpriteBatchNode addChild:platform z:1];
}

-(void)createTrashAtLocation:(CGPoint)location {
    trash = [[[Trash alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:trash z:1];
}

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * 0.25, screenSize.height * 0.95)];
            numFishCreated++;
            
        }else {
            //If the Penguin is satisfied, dont create fish
            [self unschedule:@selector(addFish)];
        }
    }    
}

-(void)addTrash {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (penguin2.characterState != kStateSatisfied) {
            [self createTrashAtLocation:ccp(screenSize.width * 0.8, screenSize.height * 0.95)];
            
        }else {
            //If the Penguin is satisfied, dont create fish
            [self unschedule:@selector(addTrash)];
        }
    }    
}

#pragma mark -
#pragma mark Menus

-(void) createPauseButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *pauseButtonNormal = [CCSprite spriteWithSpriteFrameName:@"pause.png"];
    CCSprite *pauseButtonSelected = [CCSprite spriteWithSpriteFrameName:@"pause_over.png"];
    
    pauseButton = [CCMenuItemSprite itemFromNormalSprite:pauseButtonNormal selectedSprite:pauseButtonSelected disabledSprite:nil target:self selector:@selector(doPause)];
    
    pauseButtonMenu = [CCMenu menuWithItems:pauseButton, nil];
    
    [pauseButtonMenu setPosition:ccp(winSize.width * 0.95f, winSize.height * 0.95f)];
    
    [self addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
}

-(void) createClearButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *clearButtonNormal = [CCSprite spriteWithSpriteFrameName:@"clear.png"];
    CCSprite *clearButtonSelected = [CCSprite spriteWithSpriteFrameName:@"clear_over.png"];
    
    clearButton = [CCMenuItemSprite itemFromNormalSprite:clearButtonNormal selectedSprite:clearButtonSelected disabledSprite:nil target:self selector:@selector(clearLines)];
    
    clearButtonMenu = [CCMenu menuWithItems:clearButton, nil];
    
    [clearButtonMenu setPosition:ccp(winSize.width * 0.95f, winSize.height * 0.05f)];
    
    [self addChild:clearButtonMenu z:10 tag:kButtonTagValue];
}

#pragma mark -
#pragma mark Line Drawing

- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
    
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

-(void) clearLines {
    for (NSValue *bodyPtr in lineArray) {
        b2Body *body = (b2Body*)[bodyPtr pointerValue];
        world->DestroyBody(body);
        
    }
    [lineArray removeAllObjects];
    
    for (streak in lineSpriteArray) {
        [streak removeFromParentAndCleanup:YES];
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
    self.isTouchEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel2];//Level Specific: Change for new level
}

-(void)doPause {
    
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    [[CCDirector sharedDirector] pause];
    
    pauseLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:pauseLayer z:9];
    
    CCSprite *pauseText = [CCSprite spriteWithSpriteFrameName:@"paused_text.png"];
    [pauseText setPosition:ccp(screenSize.width *0.5f, screenSize.height * 0.5f)];
    
    CCSprite *resumeButtonNormal = [CCSprite spriteWithSpriteFrameName:@"resume.png"];
    CCSprite *resumeButtonSelected = [CCSprite spriteWithSpriteFrameName:@"resume_over.png"];
    
    CCMenuItemSprite *resumeButton = [CCMenuItemSprite itemFromNormalSprite:resumeButtonNormal selectedSprite:resumeButtonSelected disabledSprite:nil target:self selector:@selector(doResume)];
    
    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
    
    pauseButtonMenu = [CCMenu menuWithItems:mainMenuButton, resumeButton, resetButton, nil];
    
    [pauseButtonMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
    [pauseButtonMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.25f)];
    
    [pauseLayer addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
    [pauseLayer addChild:pauseText];
    self.isTouchEnabled = NO;
    
    
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCSprite *backgroundImage;
    backgroundImage = [CCSprite spriteWithFile:@"background.png"];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
    
    [self addChild:backgroundImage z:-10 tag:0];
}

-(void) gameOver: (id)sender {
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

-(id)initWithLevel2UILayer:(Level2UILayer *)level2UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 31;
   
        [self setupBackground];
        uiLayer = level2UILayer;
        
        [self setupWorld];
        //[self setupDebugDraw];
        [self scheduleUpdate];
        [self schedule:@selector(updateTime) interval:1.0];
        [self createPauseButton];
        [self createClearButton];
        self.isTouchEnabled = YES;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        [self addChild:sceneSpriteBatchNode z:-1];
        
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.9f) ofType:kNormalBox];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.8f) ofType:kNormalBox];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.7f) ofType:kNormalBox];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.6f) ofType:kNormalBox];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.5f) ofType:kNormalBox];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.4f) ofType:kNormalBox];
        
        //[self createBoxAtLocation:ccp(winSize.width * 0.8168f, winSize.height *0.38f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.5f, winSize.height *0.1f) ofType:kBouncyBox];
        [self createBoxAtLocation:ccp(winSize.width * 0.8168f, winSize.height *0.18f) ofType:kBalloonBox];
        
        [self createPlatformAtLocation:ccp(winSize.width * 0.9f, winSize.height *0.415f) ofType:kMediumPlatform withRotation:4.7];
        
        [self createPenguin2AtLocation:ccp(winSize.width * 0.8168f, winSize.height * 0.5f)];
        
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        //[uiLayer displayText:@"Go!" andOnCompleteCallTarget:nil selector:nil];
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //create trash every so often
        //[self schedule:@selector(addTrash) interval:kTimeBetweenTrashCreation];
        
        //Add snow
        //CCParticleSystem *snowParticleSystem = [CCParticleSnow node];
        //[self addChild:snowParticleSystem];
        
    }
    return self;
}

-(void)update:(ccTime)dt {
    
    int32 velocityIterations = 3;
    int32 positionIterations = 2;

    world->Step(dt, velocityIterations, positionIterations);
    
    for(b2Body *b=world->GetBodyList(); b!=NULL; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            Box2DSprite *sprite = (Box2DSprite *) b->GetUserData();
            sprite.position = ccp(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
            sprite.rotation = CC_RADIANS_TO_DEGREES(b->GetAngle() * -1);
        }
    }
    
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    for (GameCharacter *tempChar in listOfGameObjects) {
        [tempChar updateStateWithDeltaTime:dt andListOfGameObjects:listOfGameObjects];
    }
    
    if (penguin2 != nil) {
        if (!gameOver){
            if (penguin2.characterState == kStateSatisfied) {
                gameOver = true;
                CCSprite *gameOverText = [CCSprite spriteWithSpriteFrameName:@"Passed.png"];
                [uiLayer displayText:gameOverText andOnCompleteCallTarget:self selector:@selector(gameOver:)];
            } else {
                if (remainingTime <= 0) {
                    gameOver = true;
                    CCSprite *gameOverText = [CCSprite spriteWithSpriteFrameName:@"Failed.png"];
                    [uiLayer displayText:gameOverText andOnCompleteCallTarget:self selector:@selector(gameOver:)];
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
    
    remainingTime = remainingTime - 1.0;
    
    if (!gameOver){    
        [uiLayer displaySecs:remainingTime];
    }
}




@end