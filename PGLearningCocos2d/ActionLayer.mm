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
#import "Flurry.h"
#import "UILayer.h"
#import "GameState.h"
#import "GCHelper.h"

@implementation ActionLayer 

@synthesize isPaused,gameOver,remainingTime;

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
//    self.isAccelerometerEnabled = TRUE;
    
    //This keeps bodies from getting stuck together. Also might be helpful when playing sounds
    //Causes fast moving fish to move through a line - look into maximum velocity for fish
    world->SetContinuousPhysics(true);
    
    
    // TODO: Find a better place for this
    lineImage = @"Start.png";
    lineLength = 30;
    lineWidth = 7.5; 
    if (CC_CONTENT_SCALE_FACTOR() == 2.0f && [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        lineLength = 50;
        lineWidth = 10;
    } else if (CC_CONTENT_SCALE_FACTOR() == 1.0f && [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        lineLength = 20;
        lineWidth = 5;
    }
    //streak = [[CCRibbon alloc]init];
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
    [sceneSpriteBatchNode addChild:penguin2 z:kPenguinZValue tag:kPenguinSpriteTagValue];
}

-(Box2DSprite *)createFish2AtLocation:(CGPoint)location {
    fish2 = [[[Fish2 alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:fish2 z:kFishZValue tag:kFishSpriteTagValue];
    return fish2;
}

-(Box2DSprite*)createBoxAtLocation:(CGPoint)location ofType:(BoxType)boxType withRotation:(float)rotation{
    box = [[[Box alloc]initWithWorld:world atLocation:location ofType:boxType withRotation:rotation]autorelease];
    
    switch (boxType) {
        case kNormalBox:
            [sceneSpriteBatchNode addChild:box z:kBoxZValue tag:kNormalBoxTag];
            break;
        case kBouncyBox:
            [sceneSpriteBatchNode addChild:box z:kBoxZValue tag:kBouncyBoxTag];
            break;
        case kBalloonBox:
            [sceneSpriteBatchNode addChild:box z:kBoxZValue tag:kBalloonBoxTag];
            break;   
        default:
            [sceneSpriteBatchNode addChild:box z:kBoxZValue];
            break;
    }
    
    
        
    
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

-(Box2DSprite *)createTrashAtLocation:(CGPoint)location {
    trash = [[[Trash alloc]initWithWorld:world atLocation:location]autorelease];
    [sceneSpriteBatchNode addChild:trash z:kTrashZValue tag:kTrashSpriteTagValue];
    return trash;
}

-(Box2DSprite*)createPlatformAtLocation:(CGPoint)location ofType:(PlatformType)platformType withRotation:(float) rotation {
    platform = [[[Platform alloc]initWithWorld:world atLocation:location ofType:platformType withRotation:rotation]autorelease];
    [sceneSpriteBatchNode addChild:platform z:kPlatformZValue tag:kPlatformTag];
    return platform;
}

-(void)addFish {
    CCLOG(@"ActionLayer->addFish method should be overridden");   
}

-(void)addTrash {
    CCLOG(@"ActionLayer->addTrash method should be overridden");
}

#pragma mark -
#pragma mark Menus

-(CCMenu*)createMenu {
    CCSprite *nextLevelButtonNormal = [CCSprite spriteWithSpriteFrameName:@"next_button.png"];
    CCSprite *nextLevelButtonSelected = [CCSprite spriteWithSpriteFrameName:@"next_button_over.png"];
    
    CCMenuItemSprite *nextLevelButton = [CCMenuItemSprite itemFromNormalSprite:nextLevelButtonNormal selectedSprite:nextLevelButtonSelected disabledSprite:nil target:self selector:@selector(doNextLevel)];
    
    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
    
    CCMenu *menu = [CCMenu menuWithItems:nextLevelButton, mainMenuButton, resetButton, nil];
    
    return menu;
}

-(CCMenu*)createFailedMenu {
    CCSprite *nextLevelButtonNormal = [CCSprite spriteWithSpriteFrameName:@"skip.png"];
    CCSprite *nextLevelButtonSelected = [CCSprite spriteWithSpriteFrameName:@"skip_over.png"];
    
    CCMenuItemSprite *nextLevelButton = [CCMenuItemSprite itemFromNormalSprite:nextLevelButtonNormal selectedSprite:nextLevelButtonSelected disabledSprite:nil target:self selector:@selector(doNextLevel)];
    
    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
    
    CCMenu *menu = [CCMenu menuWithItems:resetButton, mainMenuButton, nextLevelButton, nil];
    
    return menu;
}

-(void)createTopBar {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *topBar = [CCSprite spriteWithFile:@"top_bar.png"];
    [topBar setPosition:ccp(winSize.width * .5,winSize.height - [topBar boundingBox].size.height/2)];
    [self addChild:topBar z:9];
}

-(void) createPauseButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *pauseButtonNormal = [CCSprite spriteWithSpriteFrameName:@"pause.png"];
    CCSprite *pauseButtonSelected = [CCSprite spriteWithSpriteFrameName:@"pause_over.png"];
    
    [pauseButtonNormal setScale:1.1];
    [pauseButtonSelected setScale:1.1];
    
    pauseButton = [CCMenuItemSprite itemFromNormalSprite:pauseButtonNormal selectedSprite:pauseButtonSelected disabledSprite:nil target:self selector:@selector(doPause)];
    
    pauseButtonMenu = [CCMenu menuWithItems:pauseButton, nil];
    
    [pauseButtonMenu setPosition:ccp(winSize.width * 0.06f, winSize.height * 0.95f)];
    
    [self addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
}

-(void) createClearButton {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *clearButtonNormal = [CCSprite spriteWithSpriteFrameName:@"undo.png"];
    CCSprite *clearButtonSelected = [CCSprite spriteWithSpriteFrameName:@"undo_over.png"];
    
    [clearButtonNormal setScale:1.1];
    [clearButtonSelected setScale:1.1];
    
    clearButton = [CCMenuItemSprite itemFromNormalSprite:clearButtonNormal selectedSprite:clearButtonSelected disabledSprite:nil target:self selector:@selector(clearLines)];
    
    clearButtonMenu = [CCMenu menuWithItems:clearButton, nil];
    
    [clearButtonMenu setPosition:ccp(winSize.width * 0.931f, winSize.height * 0.95f)];
    
    [clearButtonMenu setIsTouchUp:NO];
    
    [self addChild:clearButtonMenu z:10 tag:kButtonTagValue];
}

#pragma mark -
#pragma mark Line Drawing

- (BOOL)ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event {
    wasJustATap = YES;
    CGPoint pt = [self convertTouchToNodeSpace:touch];
	_lastPt = pt;
    
    // create the streak object and add it to the scene
//    streak = [CCMotionStreak streakWithFade:200 minSeg:1 image:lineImage width:5 length:20 color:ccc4(255,255,255,255)];
    
    streak = [CCRibbon ribbonWithWidth:lineWidth image:lineImage length:lineLength color:ccc4(255,255,255,255) fade:0];
    
    [self addChild:streak];
    [lineSpriteArray addObject:streak];
    
    //[streak setPosition:end];
    [streak addPointAt:pt width:lineWidth];
    
	return YES;
}


- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
    
    end = [touch previousLocationInView:[touch view]];
    end = [[CCDirector sharedDirector] convertToGL:end];
    
    //This code will draw the line above the user's finger, but it doesnt feel right
//    end.y = end.y + 25;
    
    float distance = ccpDistance(_lastPt, end);
    
    
    
    
    if (distance > 10) {
        wasJustATap = NO;
                
        //[streak setPosition:end];
        [streak addPointAt: end width:lineWidth];
        
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
    
    //This solves the line clearing bug
    //No lines were being cleared if the touch was too small to draw a line
//    if (readyToStoreLine) {
//        
//        CCLOG(@"+++++++++++??????");
    if (wasJustATap) {
        //It was just a tap, so dont store the line
        //we only put the sprite array in here because its the only one
        //we store in touchbegan
        [lineSpriteArray removeAllObjects];
    } else {
        
        NSArray *newBodyArray = [lineArray copy];//+1 to the retain count of newBodyArray
        NSArray *newSpriteArray = [lineSpriteArray copy];//+1 to the retain count of newSpriteArray
        
        [lineArrayMaster addObject:newBodyArray];//+1 to the retain count of newBodyArray
        [lineSpriteArrayMaster addObject:newSpriteArray];//+1 to the retain count of newSpriteArray
        
        //clear out all the lines so new lines can be added
        [lineSpriteArray removeAllObjects];
        [lineArray removeAllObjects];
        
        //Release these 2 arrays so they will be released when 
        //their respective master arrays get released (lineArrayMaster and lineSpriteMasterArray)
        [newBodyArray release];//-1 to the retain count     (currently at 1)
        [newSpriteArray release];//-1 to the retain count   (currently at 1)
    }
//    }
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
    self.isPaused = NO;
    self.isTouchEnabled = YES;
    clearButton.isEnabled = YES;
    pauseButton.isEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [self removeChild:pauseLayer cleanup:YES];
}

-(void) doReturnToMainMenu {
    self.isTouchEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [[GameManager sharedGameManager] runSceneWithID:kLevelSelectScene];
}

-(void) doResetLevel {
    CCLOG(@"ActionLayer->doResetLevel method should be overridden");
}

-(void) doNextLevel {
    CCLOG(@"ActionLayer->doNextLevel method should be overridden");
}

-(void) skipButtonPressed{
    [[CCDirector sharedDirector] resume];
    [self doNextLevel];
}

-(void)pauseGame
{
//    ccColor4B c = {100,100,0,100};
//    PauseLayer * p = [[[PauseLayer alloc]initWithColor:c]autorelease];
//    [self.parent addChild:p z:10];
//    [self onExit];
}

-(void)doPause {
    self.isPaused = YES;
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    
    //[self pauseGame];
    
    [[CCDirector sharedDirector] pause];
    
    pauseLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:pauseLayer z:9];
    
    if ([[GameManager sharedGameManager]lastLevelPlayed] > 100 ) {
        CCLabelBMFont *currentLevelText = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"level %i",[[GameManager sharedGameManager]lastLevelPlayed]-100] fntFile:kFONT];
        [currentLevelText setPosition:ccp(screenSize.width * 0.5, screenSize.height * 0.725)];
        [pauseLayer addChild:currentLevelText];
    }
    
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
    
    CCSprite *skipButtonNormal = [CCSprite spriteWithSpriteFrameName:@"skip.png"];
    CCSprite *skipButtonSelected = [CCSprite spriteWithSpriteFrameName:@"skip_over.png"];
    
    CCMenuItemSprite *skipButton = [CCMenuItemSprite itemFromNormalSprite:skipButtonNormal selectedSprite:skipButtonSelected target:self selector:@selector(skipButtonPressed)];
    
    [skipButton setScale:.75];
    
    pauseButtonMenu = [CCMenu menuWithItems:resumeButton, resetButton, mainMenuButton, skipButton, nil];
    
    [pauseButtonMenu alignItemsVerticallyWithPadding:screenSize.height * 0.02f];
    [pauseButtonMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.5f)];
    
    [pauseLayer addChild:pauseButtonMenu z:10 tag:kButtonTagValue];
    [pauseLayer addChild:pauseText];
    self.isTouchEnabled = NO;
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:[[GameManager sharedGameManager]lastLevelPlayed]-100];
    if (levelHighScore > 0) {
        NSString *levelScoreString = [NSString stringWithFormat:@"Level %i high score: %d",[[GameManager sharedGameManager]lastLevelPlayed]-100, levelHighScore];
        CCLabelBMFont *levelScoreText = [CCLabelBMFont labelWithString:levelScoreString fntFile:kFONT];
        [levelScoreText setScale:.67];
        levelScoreText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.1f);
        [pauseLayer addChild:levelScoreText z:10];
    }
    
    
    //Show total high score
    NSInteger totalHighScore = [app getTotalHighScore];
    if (totalHighScore > 0) {
        NSString *highScoreString = [NSString stringWithFormat:@"Total high score: %d", totalHighScore];
        CCLabelBMFont *highScoreText = [CCLabelBMFont labelWithString:highScoreString fntFile:kFONT];
        [highScoreText setScale:.67];
        highScoreText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.05f);
        [pauseLayer addChild:highScoreText z:10];
    }
    
    
    
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
    
    
    
    CCMenu *nextLevelMenu = [self createFailedMenu];
    [nextLevelMenu alignItemsVerticallyWithPadding:winSize.height * 0.04f];
    [nextLevelMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
    [self addChild:nextLevelMenu z:10];
    
    if ([[GameManager sharedGameManager]lastLevelPlayed] > 100 ) {
        CCLabelBMFont *currentLevelText = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"level %i",[[GameManager sharedGameManager]lastLevelPlayed]-100] fntFile:kFONT];
        [currentLevelText setPosition:ccp(winSize.width * 0.5, winSize.height * 0.7)];
        [self addChild:currentLevelText z:10];
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:[[GameManager sharedGameManager]lastLevelPlayed]-100];
    if (levelHighScore > 0) {
        NSString *levelScoreString = [NSString stringWithFormat:@"Level %i high score: %d",[[GameManager sharedGameManager]lastLevelPlayed]-100, levelHighScore];
        CCLabelBMFont *levelScoreText = [CCLabelBMFont labelWithString:levelScoreString fntFile:kFONT];
        [levelScoreText setScale:.67];
        levelScoreText.position = ccp(winSize.width * 0.5f, winSize.height * 0.1f);
        [self addChild:levelScoreText z:10];
    }
    
    
    //Show total high score
    NSInteger totalHighScore = [app getTotalHighScore];
    if (totalHighScore > 0) {
        NSString *highScoreString = [NSString stringWithFormat:@"Total high score: %d", totalHighScore];
        CCLabelBMFont *highScoreText = [CCLabelBMFont labelWithString:highScoreString fntFile:kFONT];
        [highScoreText setScale:.67];
        highScoreText.position = ccp(winSize.width * 0.5f, winSize.height * 0.05f);
        [self addChild:highScoreText z:10];
    }
    
}

-(id)initWithLevel1UILayer:(UILayer *)UILayer {
    CCLOG(@"ActionLayer->initWithLevel*Layer method should be overridden");
    return nil;
}

// convenience method to convert a CGPoint to a b2Vec2
-(b2Vec2)toMeters:(CGPoint)point
{
    return b2Vec2(point.x / PTM_RATIO, point.y / PTM_RATIO);
}

// convenience method to convert a b2Vec2 to a CGPoint
-(CGPoint)toPixels:(b2Vec2)vec
{
    return ccpMult(CGPointMake(vec.x, vec.y), PTM_RATIO);
}

-(void)update:(ccTime)dt {
    
    int32 velocityIterations = 3;
    int32 positionIterations = 2;
    
    world->Step(dt, velocityIterations, positionIterations);
    
    for(b2Body *b=world->GetBodyList(); b!=NULL; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            
            
            //This check allows us to move static bodies via their sprite (important for moving objects)
            if (b->GetType() == b2_dynamicBody) {
                //Update sprite position //works but only in one constant direction
                Box2DSprite *sprite = (Box2DSprite *) b->GetUserData();
                sprite.position = ccp(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
                sprite.rotation = CC_RADIANS_TO_DEGREES(b->GetAngle() * -1);
            } else {
                Box2DSprite *sprite = (Box2DSprite*)b->GetUserData();
                // and this would do the exact opposite
                b2Vec2 pos = [self toMeters:sprite.position];
                b->SetTransform(pos, CC_DEGREES_TO_RADIANS(sprite.rotation * -1));
                b->SetLinearVelocity(b2Vec2(0.0f, 0.0f));
                b->SetAngularVelocity(0.0f);
            }
            
            
            

            
            
            
            
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
            NSString *numFishText = [NSString stringWithFormat:@"%d/%i", penguin2.numFishEaten, penguin2.numFishRequired];
            [uiLayer displayNumFish:numFishText];
            
            //Change this so that if he is angry, you can still win the game
            //if (penguin2.characterState == kStateSatisfied) {
            if (penguin2.numFishEaten >= penguin2.numFishRequired) {
                if (remainingTime == 1) {
                    gameOver = true;
                    CCSprite *gameOverText = [CCSprite spriteWithSpriteFrameName:@"buzzer_beater.png"];
                    
                    [gameOverText setTag:kBuzzerBeaterSpriteTag];
                    if ([GameState sharedInstance].numBuzzerBeaters < kMaxNumBuzzerBeaters) {
                        [GameState sharedInstance].numBuzzerBeaters++;
                        [[GameState sharedInstance] save];
                        double pctComplete = ((double)[GameState sharedInstance].numBuzzerBeaters / (int)kMaxNumBuzzerBeaters) * 100.0;
                        [[GCHelper sharedInstance]reportAchievement:kAchievement5BuzzerBeaters percentComplete:pctComplete];
                        if ([GameState sharedInstance].numBuzzerBeaters >= kMaxNumBuzzerBeaters) {
                            [gameOverText setTag:kAchievementUnlockedBuzzerBeater];
                        }
                    }
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
    
//    std::vector<MyContact>::iterator pos;
//    for(pos = _contactListener->_contacts.begin(); 
//        pos != _contactListener->_contacts.end(); ++pos) {
//        MyContact contact = *pos;
//        
//        
//        
//        if (contact.fixtureA->GetBody()->GetUserData() != NULL && contact.fixtureB->GetBody()->GetUserData() != NULL) {
//            CCSprite *spriteA = (CCSprite*)contact.fixtureA->GetBody()->GetUserData();
//            CCSprite *spriteB = (CCSprite*)contact.fixtureB->GetBody()->GetUserData();
//            
//            if ((spriteA.tag == kFishSpriteTagValue && spriteB.tag == kBouncyBoxTag) ||
//                (spriteA.tag == kBouncyBoxTag && spriteB.tag == kFishSpriteTagValue)) {
//                CCLOG(@"Fish hit BouncyBox!");
//            }
//        }
//    }
    
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
}

//-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
//    b2Vec2 oldGravity = world->GetGravity();
//    b2Vec2 gravity(acceleration.x * kAccelerometerMultiplier, oldGravity.y);
//    world->SetGravity(gravity);
//}

-(void)onEnter {
    [self setTag:kActionLayer];
    appDel = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [super onEnter];
}

- (void)onExit {
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

@end
