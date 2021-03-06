//
//  Level17ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level17ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "Flurry.h"
#import "math.h"

@implementation Level17ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * 0.15f, screenSize.height * 1.05f)];
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
        if (!gameOver) {
            [self createTrashAtLocation:ccp(screenSize.width * 0.15, screenSize.height * 1.05)];
            
            [self unschedule:@selector(addTrash)];
        }else {
            //If the Penguin is satisfied, dont create fish
            [self unschedule:@selector(addTrash)];
        }
    }    
}

#pragma mark -
#pragma mark Pause Stuff

-(void) doResetLevel {
    self.isTouchEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel17];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level18unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:18]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel18];
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCSprite *backgroundImage;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        backgroundImage = [CCSprite spriteWithFile:@"snow_bg_iPad.png"];
    }else {
        backgroundImage = [CCSprite spriteWithFile:@"snow_bg.png"];
    }
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
    
    [self addChild:backgroundImage z:-10 tag:0];
}

-(void)doHighScoreStuff {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //Get app delegate (used for high scores)
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    //Show level High Score (new high scores only)
    if (remainingTime > [app getHighScoreForLevel:kLevel17] && [app getHighScoreForLevel:kLevel17] > 0) {
        NSString *levelHighScoreText = [NSString stringWithFormat:@"New High Score!"];
        CCLabelBMFont *levelHighScoreLabel = [CCLabelBMFont labelWithString:levelHighScoreText fntFile:kFONT];
        levelHighScoreLabel.position = ccp(winSize.width * 0.5f, winSize.height * 0.25f);
        [self addChild:levelHighScoreLabel z:10];
        
        CCParticleExplosion *explosion = [CCParticleExplosion node];
        [explosion autoRemoveOnFinish];
        explosion.position = levelHighScoreLabel.position;
        [explosion setSpeed:50];
        [self addChild:explosion z:10];
    }
    
    
    //Set the High Score (if new value is greater than old value)
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel17];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel17];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 17 high score: %d", levelHighScore];
    CCLabelBMFont *levelScoreText = [CCLabelBMFont labelWithString:levelScoreString fntFile:kFONT];
    [levelScoreText setScale:.67];
    levelScoreText.position = ccp(winSize.width * 0.48f, winSize.height * 0.1f);
    [self addChild:levelScoreText z:10];
    
    
    //Show total high score
    NSInteger totalHighScore = [app getTotalHighScore];
    
    NSString *highScoreString = [NSString stringWithFormat:@"Total high score: %d", totalHighScore];
    CCLabelBMFont *highScoreText = [CCLabelBMFont labelWithString:highScoreString fntFile:kFONT];
    [highScoreText setScale:.67];
    highScoreText.position = ccp(winSize.width * 0.48f, winSize.height * 0.05f);
    [self addChild:highScoreText z:10];
    
    if ([[GameManager sharedGameManager]lastLevelPlayed] > 100 ) {
        CCLabelBMFont *currentLevelText = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"level %i",[[GameManager sharedGameManager]lastLevelPlayed]-100] fntFile:kFONT];
        [currentLevelText setPosition:ccp(winSize.width * 0.5, winSize.height * 0.7)];
        [self addChild:currentLevelText z:10];
    }
}

-(void) gameOverPass: (id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level18unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:18]];
    }
    
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    self.isTouchEnabled = NO;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayerColor *levelCompleteLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:levelCompleteLayer z:9];

    CCMenu *nextLevelMenu = [self createMenu];
    [nextLevelMenu alignItemsVerticallyWithPadding:winSize.height * 0.04f];
    [nextLevelMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
    [self addChild:nextLevelMenu z:10];
    
    [self doHighScoreStuff];
    
}

-(void)createBoxAtWidth:(float)xPosition {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    
    CCMoveTo *mov1 = [CCMoveTo actionWithDuration:VEL_TO_SEC((1.1 - xPosition), 2.5) position:ccp(winSize.width * 1.1f,winSize.height * 0.1f)];
    CCMoveTo *mov2 = [CCMoveTo actionWithDuration:0 position:ccp(winSize.width * -.1, winSize.height * 0.1f)];
    CCMoveTo *mov3 = [CCMoveTo actionWithDuration:VEL_TO_SEC((xPosition + .1), 2.5) position:ccp(winSize.width * xPosition, winSize.height * 0.1f)];
    CCSequence *seq = [CCSequence actions:mov1,mov2,mov3, nil];
    
    int myInt = (int)(xPosition*10);
    
    if (myInt % 4 == 0) {
        Box2DSprite *myBox = [self createBoxAtLocation:ccp(winSize.width * xPosition, winSize.height * 0.1f) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
    [myBox runAction:[CCRepeatForever actionWithAction:seq]];
    
        
    } else {
        [[self createBoxAtLocation:ccp(winSize.width * xPosition, winSize.height * 0.1f) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)]runAction:[CCRepeatForever actionWithAction:seq]];
    }
    
    
}

-(id)initWithLevel17UILayer:(UILayer *)level17UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [Flurry logEvent:@"Level 17 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 31;
   
        [self setupBackground];
        uiLayer = level17UILayer;
        
        [self setupWorld];
        //[self setupDebugDraw];
        [self scheduleUpdate];
        [self schedule:@selector(updateTime) interval:1.0];
        [self createPauseButton];
        [self createClearButton];
        self.isTouchEnabled = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas_iPad.png"];
        }else {
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        }
        [self addChild:sceneSpriteBatchNode z:-1];
        
        
        
        
        

//        CCSprite*mySprite = [self createBoxAtLocation:ccp(winSize.width*0.1f, winSize.height*0.85f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.1f, winSize.height*0.77f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.1f, winSize.height*0.69f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.1f, winSize.height*0.61f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.22f, winSize.height*0.61f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.34f, winSize.height*0.61f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.1f, winSize.height*0.61f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.46f, winSize.height*0.61f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.46f, winSize.height*0.69f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.46f, winSize.height*0.77f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.46f, winSize.height*0.85f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        
//        [mySprite runAction:[CCRepeatForever actionWithAction: [CCSequence actions:
//                         [CCMoveTo actionWithDuration:1.0 position:ccp(300,100)],
//                         [CCMoveTo actionWithDuration:1.0 position:ccp(200,200)],
//                         [CCMoveTo actionWithDuration:1.0 position:ccp(100,100)],
//                         nil]]];
//        
//        [mySprite runAction:[CCMoveTo actionWithDuration:2.0 position:ccp(winSize.width*0.5f,winSize.height*0.5f)]];
//        
//        
//        //Bottom line of balloons
//        //[self createBoxAtLocation:ccp(winSize.width*0.05f, winSize.height*0.1f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        //[self createBoxAtLocation:ccp(winSize.width*0.17f, winSize.height*0.1f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        //[self createBoxAtLocation:ccp(winSize.width*0.29f, winSize.height*0.1f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        //[self createBoxAtLocation:ccp(winSize.width*0.41f, winSize.height*0.1f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        //[self createBoxAtLocation:ccp(winSize.width*0.53f, winSize.height*0.1f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        //[self createBoxAtLocation:ccp(winSize.width*0.65f, winSize.height*0.1f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        [self createBoxAtLocation:ccp(winSize.width*0.93f, winSize.height*0.1f) ofType:kBalloonBox withRotation:DEG_TO_RAD(0)];
//        
//        
//        myBody = [self createMovingBoxAtLocation:ccp(winSize.width*0.5f, winSize.height*0.25f) ofType:kMovingBouncyBox withRotation:0.0f];
//        
//        
////        b2Vec2 currentPosition = myBody->GetPosition();
////        b2Vec2 desiredPosition = b2Vec2(100.0f,100.0f);
////        b2Vec2 necessaryMovement = desiredPosition - currentPosition;
////        float necessaryDistance = necessaryMovement.Length();
////        necessaryMovement.Normalize();
////        float forceMagnitude = b2Min(1000.0f, necessaryDistance);
////        b2Vec2 force = forceMagnitude * necessaryMovement;
////        myBody->ApplyForce( force, myBody->GetWorldCenter() );
//        
//        
//        
//        //This works!
//        //myBody->SetLinearVelocity(b2Vec2(1.0f, 0.0f));
//        
//        //[self schedule:@selector(moveBox) interval:kTimeBetweenFishCreation + 1];
        
        
        [self createPenguin2AtLocation:ccp(winSize.width * 0.9f, winSize.height * 0.8f)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        [self createPlatformAtLocation:ccp(winSize.width * .95, winSize.height *0.72f) ofType:kMediumPlatform withRotation:CC_DEGREES_TO_RADIANS(270)];
        [self createPlatformAtLocation:ccp(winSize.width * 0.2f, winSize.height *0.9f) ofType:kExtraLargePlatform withRotation:0.0];
        
        for (float i = 0; i < 1.1; i=i+.2) {
            [self createBoxAtWidth:i];
        }
        
        
        
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //create trash every so often
        [self schedule:@selector(addTrash) interval:15];
        
    }
    return self;
}

//-(void)update:(ccTime)dt {
//    
//    
//    
//    int32 velocityIterations = 3;
//    int32 positionIterations = 2;
//    
//    world->Step(dt, velocityIterations, positionIterations);
//    
//    
//    //This moves the block in a triangular pattern
//    lastTimeMoved = lastTimeMoved + dt;
//    if (lastTimeMoved > 3) {
//        b2Vec2 vel = myBody->GetLinearVelocity();
//        vel.y = -3.975;
//        //vel.x = -5;
//        myBody->SetLinearVelocity(vel);
//        lastTimeMoved = 0;
//    } else if (lastTimeMoved > 2) {
//        b2Vec2 vel = myBody->GetLinearVelocity();
//        vel.y = 4;
//        vel.x = -2;
//        myBody->SetLinearVelocity(vel);
//    } else if (lastTimeMoved > 1){
//        b2Vec2 vel = myBody->GetLinearVelocity();
//        vel.x = 4;
//        vel.y = 0;
//        myBody->SetLinearVelocity(vel);
//    }
//    
//    float bodyAngle = myBody->GetAngle();
//    
//    float totalRotation = 360.0f;
//    float maxRad = 360* (M_PI/180);
//    float change = 2 * (M_PI/180); //allow 1 degree rotation per time step
//    float newAngle = bodyAngle + change;
//    //Keep from counting to infinity
//    if (newAngle >= maxRad) {
//        newAngle = 0;
//        bodyAngle = 0;
//    }
//    myBody->SetTransform( myBody->GetPosition(), newAngle );
//    
//    
//    
//    
//    //lastTimeMoved = dt;
//    
//    for(b2Body *b=world->GetBodyList(); b!=NULL; b=b->GetNext()) {
//        if (b->GetUserData() != NULL) {
//            
//            //Update sprite position //works but only in one constant direction
//            Box2DSprite *sprite = (Box2DSprite *) b->GetUserData();
//            sprite.position = ccp(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
//            sprite.rotation = CC_RADIANS_TO_DEGREES(b->GetAngle() * -1);
//            
//            
//            //b.position
//            
//            
//            
//            
//            //update sprite position
//            ///////////////////////////added//////////////////////
//            //            CCSprite *newSprite = (CCSprite *)b->GetUserData();
//            //            
//            //            b2Vec2 b2Position = b2Vec2(newSprite.position.x/PTM_RATIO,
//            //                                       newSprite.position.y/PTM_RATIO);
//            //            float32 b2Angle = -1 * CC_DEGREES_TO_RADIANS(newSprite.rotation);
//            //            
//            //            b->SetTransform(b2Position, b2Angle);
//            
//        }
//    }
//    
//    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
//    for (GameCharacter *tempChar in listOfGameObjects) {
//        [tempChar updateStateWithDeltaTime:dt andListOfGameObjects:listOfGameObjects];
//    }
//    
//    if (penguin2 != nil) {
//        if (!gameOver){
//            NSString *numFishText = [NSString stringWithFormat:@"%d/5", penguin2.numFishEaten];
//            //[uiLayer displayNumFish:numFishText];
//            
//            if (penguin2.characterState == kStateSatisfied) {
//                gameOver = true;
//                CCSprite *gameOverText = [CCSprite spriteWithSpriteFrameName:@"Passed.png"];
//                
//                //[uiLayer displayText:gameOverText andOnCompleteCallTarget:self selector:@selector(gameOverPass:)];
//            } else {
//                if (remainingTime <= 0) {
//                    gameOver = true;
//                    CCSprite *gameOverText = [CCSprite spriteWithSpriteFrameName:@"Failed.png"];
//                    //[uiLayer displayText:gameOverText andOnCompleteCallTarget:self selector:@selector(gameOverFail:)];
//                }
//            }
//        }
//    }
//    
//}

@end
