//
//  Level22ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level22ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"
#import "math.h"

@implementation Level22ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * -.03,screenSize.height * .35)];
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
            [self createTrashAtLocation:ccp(screenSize.width * -.03,screenSize.height * .35)];
            
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel22];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level23unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:23]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel23];
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
    if (remainingTime > [app getHighScoreForLevel:kLevel22] && [app getHighScoreForLevel:kLevel22] > 0) {
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
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel22];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel22];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 22 high score: %d", levelHighScore];
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
    [defaults setBool:YES forKey:@"level23unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:23]];
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

-(id)initWithLevel22UILayer:(UILayer *)level22UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [FlurryAnalytics logEvent:@"Level 22 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 60;
   
        [self setupBackground];
        uiLayer = level22UILayer;
        
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
        
        [self createPenguin2AtLocation:ccp(winSize.width * .9, winSize.height * .36)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        //[self createPlatformAtLocation:ccp(winSize.width * 0.9f, winSize.height *0.315f) ofType:kMediumPlatform withRotation:4.7];
//        [self createBoxAtLocation:ccp(winSize.width * 0.9f, winSize.height *0.285f) ofType:kNormalBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        for (float i = 0; i < .286; i=i+.081) {
            [self createBoxAtLocation:ccp(winSize.width * .9,winSize.height * i) ofType:kNormalBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        }
        
        [self createPlatformAtLocation:ccp(0, winSize.height * .3) ofType:kSmallPlatform withRotation:CC_DEGREES_TO_RADIANS(85)];
        
        //[self createPlatformAtLocation:ccp(winSize.width * .5,winSize.height * .25) ofType:kExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(180)];
        
        //Box2DSprite *myPlatform = [self createPlatformAtLocation:ccp(winSize.width * .25,winSize.height * .3) ofType:kLargePlatform withRotation:CC_DEGREES_TO_RADIANS(90)];
        
        [self createBoxAtLocation:ccp(winSize.width * .3,winSize.height * .05) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
       // Box2DSprite *myBox2 = [self createBoxAtLocation:ccp(winSize.width * .25,winSize.height * .8) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(15)];
        
        
        
        
//        [self createBoxAtLocation:ccp(winSize.width * .8,winSize.height * .05) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(-45)];
//        [self createBoxAtLocation:ccp(winSize.width * .05,winSize.height * .25) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(25)];
//        [self createBoxAtLocation:ccp(winSize.width * .85,winSize.height * .6) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(-20)];
        

//        CCDelayTime *mov1 = [CCDelayTime actionWithDuration:2];
//        CCRotateTo *mov2 = [CCMoveTo actionWithDuration:.05 position:ccp(winSize.width * .9,winSize.height * .1)];
//        CCRotateTo *mov3 = [CCMoveTo actionWithDuration:2 position:ccp(winSize.width,winSize.height * .1)];
//        CCSequence *seq = [CCSequence actions:mov1,mov2,mov3, nil];
        
        //[bouncyBox runAction:[CCRepeatForever actionWithAction:seq]];
        
        
        
        [self createBoxAtLocation:ccp(winSize.width * .75,winSize.height * .3) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width * .76,winSize.height * .57) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width * .37,winSize.height * .7) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width * .67,winSize.height * .67) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width * .45,winSize.height * .48) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width * .22,winSize.height * .48) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width * .6,winSize.height * .35) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
//        
//        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.2 angle:-1.0];
//        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.2 angle:0.0];
//        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.2 angle:1.0];
//        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //create trash every so often
        [self schedule:@selector(addTrash) interval:5];
        
    }
    return self;
}


@end
