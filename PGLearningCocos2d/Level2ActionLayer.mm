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
    [super dealloc];
}

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

- (void)createGround {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float32 margin = -15.0f;
    b2Vec2 lowerLeft = b2Vec2(margin/PTM_RATIO, margin/PTM_RATIO);
    b2Vec2 lowerRight = b2Vec2((winSize.width-margin)/PTM_RATIO, margin/PTM_RATIO);
    b2Vec2 upperRight = b2Vec2((winSize.width-margin)/PTM_RATIO,(winSize.height-margin)/PTM_RATIO);
    b2Vec2 upperLeft = b2Vec2(margin/PTM_RATIO, (winSize.height-margin)/PTM_RATIO);
    
    b2BodyDef groundBodyDef;
    groundBodyDef.type = b2_staticBody;
    groundBodyDef.position.Set(0, 0);
    groundBody = world->CreateBody(&groundBodyDef);
    
    b2PolygonShape groundShape;
    b2FixtureDef groundFixtureDef;
    groundFixtureDef.shape = &groundShape;
    groundFixtureDef.density = 0.0;
    
    groundShape.SetAsEdge(lowerLeft, upperLeft);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(lowerLeft, lowerRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(lowerRight, upperRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(upperLeft, upperRight);
    groundBody->CreateFixture(&groundFixtureDef);
}

-(void)createPenguin2AtLocation:(CGPoint)location {
    penguin2 = [[[Penguin2 alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:penguin2 z:1 tag:kPenguinSpriteTagValue];
}

-(void)createFish2AtLocation:(CGPoint)location {
    fish2 = [[[Fish2 alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:fish2 z:1 tag:111];
}

-(void)createBoxAtLocation:(CGPoint)location {
    box = [[[Box alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:box z:1];
}

-(void)createTrashAtLocation:(CGPoint)location {
    trash = [[[Trash alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:trash z:1];
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void)setupBackground {
    CCSprite *backgroundImage;
    backgroundImage = [CCSprite spriteWithFile:@"background.png"];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
    
    [self addChild:backgroundImage z:-10 tag:0];
}

-(void) doResume {
    self.isTouchEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [self removeChild:pauseLayer cleanup:YES];
}

-(void) doReturnToMainMenu {
    self.isTouchEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

-(void)doPause
{
    //	ccColor4B c ={0,0,0,150};
    //	[PauseLayer layerWithColor:c delegate:self];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    [[CCDirector sharedDirector] pause];
    
    pauseLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:pauseLayer z:5];
    
    
    CCSprite *resumeButtonNormal = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonNormal.png"];
    CCSprite *resumeButtonSelected = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonSelected.png"];
    
    CCMenuItemSprite *resumeButton = [CCMenuItemSprite itemFromNormalSprite:resumeButtonNormal selectedSprite:resumeButtonSelected disabledSprite:nil target:self selector:@selector(doResume)];
    
    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    pauseButtonMenu = [CCMenu menuWithItems:backButton, resumeButton, nil];
    
    [pauseButtonMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
    [pauseButtonMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.25f)];
    
    [pauseLayer addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
    self.isTouchEnabled = NO;
    
    
}

-(void) createPauseButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *pauseButtonNormal = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonNormal.png"];
    CCSprite *pauseButtonSelected = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonSelected.png"];
    
    CCMenuItemSprite *pauseButton = [CCMenuItemSprite itemFromNormalSprite:pauseButtonNormal selectedSprite:pauseButtonSelected disabledSprite:nil target:self selector:@selector(doPause)];
    
    pauseButtonMenu = [CCMenu menuWithItems:pauseButton, nil];
    
    [pauseButtonMenu setPosition:ccp(winSize.width * 0.95f, winSize.height * 0.95f)];
    
    [self addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
}

-(void) clearLines {
    
}

-(id)initWithLevel2UILayer:(Level2UILayer *)level2UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        lineArray = [[NSMutableArray array] retain];
        
        [self setupBackground];
        uiLayer = level2UILayer;
        
        [self setupWorld];
        //[self setupDebugDraw];
        [self scheduleUpdate];
        [self createGround];
        [self createPauseButton];
        self.isTouchEnabled = YES;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        [self addChild:sceneSpriteBatchNode z:-1];
        
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.9f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.8f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.7f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.6f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.5f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.4f, winSize.height *0.4f)];
        
        //[self createBoxAtLocation:ccp(winSize.width * 0.8168f, winSize.height *0.38f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.8168f, winSize.height *0.28f)];
        [self createBoxAtLocation:ccp(winSize.width * 0.8168f, winSize.height *0.18f)];
        
        
        
        [self createPenguin2AtLocation:ccp(winSize.width * 0.8168f, winSize.height * 0.415f)];
        
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        [uiLayer displayText:@"Go!" andOnCompleteCallTarget:nil selector:nil];
        
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

-(void) gameOver: (id)sender {
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
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
        if (penguin2.characterState == kStateSatisfied) {
            if (!gameOver){
                gameOver = true;
                [uiLayer displayText:@"You Win!" andOnCompleteCallTarget:self selector:@selector(gameOver:)];
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

- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
    
    CGPoint pt = [self convertTouchToNodeSpace:touch];
	_lastPt = pt;
	return YES;
}

- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
    
    CGPoint end = [touch previousLocationInView:[touch view]];
    end = [[CCDirector sharedDirector] convertToGL:end];
    
    float distance = ccpDistance(_lastPt, end);
    
    if (distance > 5) {
        CCSprite *lineSprite = [CCSprite spriteWithFile:@"snow.png"];
        lineSprite.position = ccp(end.x, end.y);
        [self addChild:lineSprite];
    }
    
    
    if (distance > 10)
    {
        

        
        
        b2Vec2 s(_lastPt.x/PTM_RATIO, _lastPt.y/PTM_RATIO);
        b2Vec2 e(end.x/PTM_RATIO, end.y/PTM_RATIO);
        
        b2BodyDef bd;
        
        bd.type = b2_staticBody;
        bd.position.Set(0, 0);
        b2Body* body = world->CreateBody(&bd);
        
        
        
        b2PolygonShape shape;
        shape.SetAsEdge(b2Vec2(s.x, s.y), b2Vec2(e.x, e.y));
        body->CreateFixture(&shape, 0.0f);
        
        //lineSprite.position = ccp(body->GetPosition().x, body->GetPosition().y);
        //lineSprite.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
        
        
        
        _lastPt = end;
        
        
        
        
    }
    
    
}

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if ((penguin2.characterState != kStateSatisfied) && (numFishCreated < kNumFishToCreate)) {
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

- (void)createOffscreenSensorBody {
    //CGSize winSize = [CCDirector sharedDirector].winSize;
    //float32 sensorWidth = winSize.width*1.5;
    //float32 sensorHeight = winSize.height * 4;
}

@end
