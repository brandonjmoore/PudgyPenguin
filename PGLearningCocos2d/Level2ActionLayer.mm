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
#import "TouchDraw.h"
#import "Box2DHelpers.h"
#import "CCDrawingPrimitives.h"

@implementation Level2ActionLayer

-(void) dealloc {
    CCLOG(@"Level2ActionLayer dealloc");
    [lineArray release];
    [lineSpriteArray release];
    
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

-(void) createClearButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *clearButtonNormal = [CCSprite spriteWithSpriteFrameName:@"Scene2ButtonNormal.png"];
    CCSprite *clearButtonSelected = [CCSprite spriteWithSpriteFrameName:@"Scene2ButtonSelected.png"];
    
    CCMenuItemSprite *clearButton = [CCMenuItemSprite itemFromNormalSprite:clearButtonNormal selectedSprite:clearButtonSelected disabledSprite:nil target:self selector:@selector(clearLines)];
    
    clearButtonMenu = [CCMenu menuWithItems:clearButton, nil];
    
    [clearButtonMenu setPosition:ccp(winSize.width * 0.95f, winSize.height * 0.05f)];
    
    [self addChild:clearButtonMenu z:10 tag:kButtonTagValue];
}

-(void) clearLines {
    for (NSValue *bodyPtr in lineArray) {
        b2Body *body = (b2Body*)[bodyPtr pointerValue];
        world->DestroyBody(body);
        
    }
    [lineArray removeAllObjects];
    
    [streak removeFromParentAndCleanup:YES];
    //[drawPoints removeAllObjects];
    
    // remove the node from the scene
    //CCNode *drawer = [self getChildByTag:TOUCH_DRAWER_TAG];
    //[self removeChild:drawer cleanup:YES];
}

-(id)initWithLevel2UILayer:(Level2UILayer *)level2UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        permScreenSize = [CCDirector sharedDirector].winSize;
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        
        // create the streak object and add it to the scene
        //streak = [CCMotionStreak streakWithFade:60 minSeg:0 image:@"snow.png" width:5 length:21 color:ccc4(255,255,255,255)];
        //streak = [CCRibbon ribbonWithWidth:5 image:@"snow.png" length:21 color:ccc4(255,255,255,255) fade:60];
        //[self addChild:streak];
        
        
        
        
        [self setupBackground];
        uiLayer = level2UILayer;
        
        [self setupWorld];
        //[self setupDebugDraw];
        [self scheduleUpdate];
        [self createGround];
        [self createPauseButton];
        [self createClearButton];
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

-(CGRect)adjustedBoundingBox {
    //Adjust the bounding box to the size of the sprite
    //Without transparent space
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //CGRect levelBoundingBox = CGRectMake(-1.0f,-winSize.height*0.5f, winSize.width * 1.5F, winSize.height * 1.5f);
    
    CGRect levelBoundingBox = [self boundingBox];
    levelBoundingBox = CGRectMake(winSize.width * 0.5f, winSize.height * 0.5f, winSize.width * 1.5F, winSize.height * 1.5f);
    
    return levelBoundingBox;
    
}

-(void)update:(ccTime)dt {
    int32 velocityIterations = 3;
    int32 positionIterations = 2;
    CGRect myBoundingBox = [self adjustedBoundingBox];
    
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
    
    //CGPoint points[2]={{_lastPt.x,_lastPt.y},{end.x,end.y}};
    //ccDrawLines(points,2);
    
    //ccDrawLine(end, _lastPt);
    
    //DrawShape(f, xf, b2Color(0.5f, 0.9f, 0.5f));
    
}


- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
    
    CGPoint pt = [self convertTouchToNodeSpace:touch];
	_lastPt = pt;
    
    // create the streak object and add it to the scene
    streak = [CCMotionStreak streakWithFade:200 minSeg:10 image:@"Start.png" width:5 length:20 color:ccc4(255,255,255,255)];
    //streak = [CCRibbon ribbonWithWidth:1 image:@"Start.png" length:1 color:ccc4(255,255,255,255) fade:200];
    [self addChild:streak];
    [lineSpriteArray addObject:streak];
    
//    if (drawPoints == nil) {
//        drawPoints = [[NSMutableArray alloc] initWithCapacity:2];
//    }
//    
//    TouchDraw *drawer = [TouchDraw node];
//    [drawer setDrawPoints:drawPoints];
//    [drawer setTag:TOUCH_DRAWER_TAG];
//    [self addChild:drawer];
    
	return YES;
}


- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
    
    
    
    end = [touch previousLocationInView:[touch view]];
    end = [[CCDirector sharedDirector] convertToGL:end];
    
    float distance = ccpDistance(_lastPt, end);
    
//    if (distance > 5) {
//        CCSprite *lineSprite = [CCSprite spriteWithFile:@"snow.png"];
//        lineSprite.position = ccp(end.x, end.y);
//        
//        [self addChild:lineSprite];
//    }
    
    // begin drawing to the render texture
    //[target begin];
    [streak setPosition:end];
    //[streak addPointAt:end width:32];
    if (distance > 10) {
        
        //[drawPoints addObject:NSStringFromCGPoint(end)];
        //[drawPoints addObject:NSStringFromCGPoint(_lastPt)];
        
        
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
        
        //lineSprite.position = ccp(body->GetPosition().x, body->GetPosition().y);
        //lineSprite.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
        
        //const b2Transform& xf = body->GetTransform();
        
        //DrawShape(body, xf, b2Color(0.9f, 0.7f, 0.7f));
        
        //CGPoint points[2]={{_lastPt.x,_lastPt.y},{end.x,end.y}};
        //ccDrawLines(points,2);
        
        
//        int d = (int)distance;
//
//            float difx = end.x - _lastPt.x;
//            float dify = end.y - _lastPt.y;
//            [brush setPosition:ccp(_lastPt.x, _lastPt.y)];
//            [brush setRotation:rand()%360];
//            float r = ((float)(rand()%50)/50.f) + 0.25f;
//            [brush setScale:r];
//            // Call visit to draw the brush, don't call draw..
//            [brush visit];

        
        
        _lastPt = end;
        // finish drawing and return context back to the screen
        //[target end];
        
    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
     
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
    CGSize winSize = [[CCDirector sharedDirector] winSize];
//    float32 sensorWidth = winSize.width*4;
//    float32 sensorHeight = winSize.height*.25;
//    float32 sensorOffsetX = -winSize.width*2;
//    float32 sensorOffsetY = -winSize.height/2;
//    
//    b2BodyDef bodyDef;
//    bodyDef.position.Set(sensorOffsetX/PTM_RATIO + sensorWidth/2/PTM_RATIO, sensorOffsetY/PTM_RATIO + sensorHeight/2/PTM_RATIO);
//    offscreenSensorBody = world->CreateBody(&bodyDef);
//    
//    b2PolygonShape shape;
//    shape.SetAsBox(sensorWidth/2/PTM_RATIO, sensorHeight/2/PTM_RATIO);
//    
//    b2FixtureDef fixtureDef;
//    fixtureDef.shape = &shape;
//    fixtureDef.isSensor = true;
//    fixtureDef.density = 0.0;
//    
//    offscreenSensorBody->CreateFixture(&fixtureDef);
    
    
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
    groundFixtureDef.isSensor = true;
    
    groundShape.SetAsEdge(lowerLeft, upperLeft);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(lowerLeft, lowerRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(lowerRight, upperRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(upperLeft, upperRight);
    groundBody->CreateFixture(&groundFixtureDef);
}



@end
