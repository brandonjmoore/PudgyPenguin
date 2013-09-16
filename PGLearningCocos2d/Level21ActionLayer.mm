//
//  Level21ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level21ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "Flurry.h"
#import "math.h"

@implementation Level21ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * .25,screenSize.height * 1.05)];
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
            [self createTrashAtLocation:ccp(screenSize.width * .25,screenSize.height * 1.1)];
            
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel21];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level22unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:22]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel22];
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCSprite *backgroundImage;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        backgroundImage = [CCSprite spriteWithFile:@"ocean_no_block_iPad.png"];
    }else {
        backgroundImage = [CCSprite spriteWithFile:@"ocean_no_block.png"];
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
    if (remainingTime > [app getHighScoreForLevel:kLevel21] && [app getHighScoreForLevel:kLevel21] > 0) {
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
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel21];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel21];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 21 high score: %d", levelHighScore];
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
    [defaults setBool:YES forKey:@"level22unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:22]];
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

-(id)initWithLevel21UILayer:(UILayer *)level21UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [Flurry logEvent:@"Level 21 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 46;
   
        [self setupBackground];
        uiLayer = level21UILayer;
        
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
        
        [self createPenguin2AtLocation:ccp(winSize.width * .9, winSize.height * .15)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        //Ice Block
        CCSprite *iceBlock = [CCSprite spriteWithSpriteFrameName:@"iceblock.png"];
        iceBlock.position = ccp(winSize.width * .9f,winSize.height * .05f);
        [self addChild:iceBlock z:kNegTwoZValue];
        
        //Large icicle
        [self createPlatformAtLocation:ccp(winSize.width * 0.35f, winSize.height * 0.7f) ofType:kExtraLargePlatform withRotation:4.7f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.75f, winSize.height * 0.6f) ofType:kExtraLargePlatform withRotation:4.7f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.35f, winSize.height * 0.5f) ofType:kExtraLargePlatform withRotation:4.7f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.75f, winSize.height * 0.4f) ofType:kExtraLargePlatform withRotation:4.7f];
        
        //Box2DSprite *myPlatform = [self createPlatformAtLocation:ccp(winSize.width * .25,winSize.height * .3) ofType:kLargePlatform withRotation:CC_DEGREES_TO_RADIANS(90)];
        
        Box2DSprite *myBox = [self createBoxAtLocation:ccp(winSize.width * .1,winSize.height * .4) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        Box2DSprite *myBox2 = [self createBoxAtLocation:ccp(winSize.width * .9,winSize.height * .6) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
//        CCDelayTime *mov1 = [CCDelayTime actionWithDuration:3];
//        CCMoveTo *mov4 = [CCMoveTo actionWithDuration:.1 position:ccp(winSize.width * .25,winSize.height * .275)];
//        CCMoveTo *mov2 = [CCMoveTo actionWithDuration:.1 position:ccp(winSize.width * .25,winSize.height * .4)];
//        CCMoveTo *mov3 = [CCMoveTo actionWithDuration:1 position:ccp(winSize.width * .25,winSize.height * .3)];
//        CCSequence *seq = [CCSequence actions:mov1,mov4,mov2,mov3, nil];
        
        
        
        [myBox runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];
        id mov1 = [CCMoveBy actionWithDuration:4 position:ccp(winSize.width * .8,0)];
        id mov2 = [mov1 reverse];
        CCSequence *seq = [CCSequence actions:mov1,mov2, nil];
        [myBox runAction:[CCRepeatForever actionWithAction:seq]];
        
        [myBox2 runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:-360]]];
        id mov3 = [CCMoveBy actionWithDuration:4 position:ccp(winSize.width * -.8,0)];
        id mov4 = [mov3 reverse];
        CCSequence *seq2 = [CCSequence actions:mov3,mov4, nil];
        [myBox2 runAction:[CCRepeatForever actionWithAction:seq2]];
        
        
        
//        [self createBoxAtLocation:ccp(winSize.width * .8,winSize.height * .05) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(-45)];
//        [self createBoxAtLocation:ccp(winSize.width * .05,winSize.height * .25) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(25)];
//        [self createBoxAtLocation:ccp(winSize.width * .85,winSize.height * .6) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(-20)];
        

//        CCDelayTime *mov1 = [CCDelayTime actionWithDuration:2];
//        CCRotateTo *mov2 = [CCMoveTo actionWithDuration:.05 position:ccp(winSize.width * .9,winSize.height * .1)];
//        CCRotateTo *mov3 = [CCMoveTo actionWithDuration:2 position:ccp(winSize.width,winSize.height * .1)];
//        CCSequence *seq = [CCSequence actions:mov1,mov2,mov3, nil];
        
        //[bouncyBox runAction:[CCRepeatForever actionWithAction:seq]];
        
        
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //create trash every so often
        [self schedule:@selector(addTrash) interval:7];
        
    }
    return self;
}


@end
