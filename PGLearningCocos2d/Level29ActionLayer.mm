//
//  Level29ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level29ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "Flurry.h"
#import "math.h"

#import "MyColorLayer.h"

@implementation Level29ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            double val = ((double)arc4random() / ARC4RANDOM_MAX);
            [self createFish2AtLocation:ccp(screenSize.width * val,screenSize.height * 1.05)];
            //fish.body->ApplyLinearImpulse(b2Vec2(6,1), fish.body->GetWorldCenter());
            //fish.body->SetTransform(fish.body->GetPosition() , CC_DEGREES_TO_RADIANS(0));
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
            double val = ((double)arc4random() / ARC4RANDOM_MAX);
            [self createTrashAtLocation:ccp(screenSize.width * val,screenSize.height * 1.05)];
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel29];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level30unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:30]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel30];
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
    if (remainingTime > [app getHighScoreForLevel:kLevel29] && [app getHighScoreForLevel:kLevel29] > 0) {
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
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel29];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel29];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 29 high score: %d", levelHighScore];
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
    [defaults setBool:YES forKey:@"level30unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:30]];
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

-(void)createPlatformAtWidth:(float)yPosition {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int myInt = (int)(yPosition*100);
    
    if (myInt % 2 == 0) {
        [self createBoxAtLocation:ccp(0, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(45)];
        [self createBoxAtLocation:ccp(winSize.width, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(45)];
    } else {
        [self createBoxAtLocation:ccp(0, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
    }
    
    
    
}

-(id)initWithLevel29UILayer:(UILayer *)level29UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        
        
        [Flurry logEvent:@"Level 29 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 31;
   
        [self setupBackground];
        uiLayer = level29UILayer;
        
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
        
        [self createPenguin2AtLocation:ccp(winSize.width * .5, winSize.height * .05)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        [penguin2 setNumFishRequired:10];
        
        
        
        for (float i = -.2; i < 1.2; i=i+.2) {
            [self createPlatformAtLocation:ccp(winSize.width * i,winSize.height * .75) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(195)];
            [self createPlatformAtLocation:ccp(winSize.width * (i-.05),winSize.height * .75) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(-195)];
            
        }
        
        for (float i = -.1; i < 1.1; i=i+.2) {
            [self createPlatformAtLocation:ccp(winSize.width * i,winSize.height * .6) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(195)];
            [self createPlatformAtLocation:ccp(winSize.width * (i-.05),winSize.height * .6) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(-195)];
            
        }
        
        for (float i = -.2; i < 1.2; i=i+.2) {
            [self createPlatformAtLocation:ccp(winSize.width * i,winSize.height * .45) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(195)];
            [self createPlatformAtLocation:ccp(winSize.width * (i-.05),winSize.height * .45) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(-195)];
            
        }
        
        for (float i = -.1; i < 1.1; i=i+.2) {
            [self createPlatformAtLocation:ccp(winSize.width * i,winSize.height * .3) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(195)];
            [self createPlatformAtLocation:ccp(winSize.width * (i-.05),winSize.height * .3) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(-195)];
            
        }
        
        //[self createPlatformAtLocation:ccp(winSize.width *1.1,winSize.height * .8) ofType:kMediumPlatform withRotation:CC_DEGREES_TO_RADIANS(-85)];
        
        
//        MyColorLayer *testLayer = [MyColorLayer layerWithColor:ccc4(255, 255, 224, 100)];
//        [testLayer setScale:.5];
//        testLayer.isTouchEnabled = YES;
//        //[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:testLayer priority:1 swallowsTouches:YES];
//        [self addChild:testLayer];


        
//        for (float i = .1; i < .9; i=i+.15) {
//            [self createPlatformAtWidth:i];
//        }
        
        //[self createPlatformAtLocation:ccp(winSize.width * .05,winSize.height * .5) ofType:kExtraExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        //[self createBoxAtLocation:ccp(winSize.width * 0.3,winSize.height * .05) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:1.5];
        
        //create trash every so often
        [self schedule:@selector(addTrash) interval:2.5];
        
    }
    return self;
}


@end
