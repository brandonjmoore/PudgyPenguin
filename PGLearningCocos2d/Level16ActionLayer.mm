//
//  Level16ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level16ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"
#import "math.h"

@implementation Level16ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * 0.5f, screenSize.height * 1.05f)];
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
            [self createTrashAtLocation:ccp(screenSize.width * 0.5f, screenSize.height * 1.1f)];
            
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel16];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level17unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:17]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel17];
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
    if (remainingTime > [app getHighScoreForLevel:kLevel16] && [app getHighScoreForLevel:kLevel16] > 0) {
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
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel16];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel16];
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
    [defaults setBool:YES forKey:@"level17unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:17]];
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

-(void)addBalloons {
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    Box2DSprite *myBalloon = [self createBoxAtLocation:ccp(winSize.width * val,winSize.height * -.05) ofType:kBalloonBox withRotation:0];
    
    [myBalloon runAction:[CCMoveTo actionWithDuration:15 position:ccp(winSize.width * val,winSize.height * 1.05)]];
    
    CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.2 angle:-4.0];
    CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.2 angle:0.0];
    CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.2 angle:4.0];
    CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
    [myBalloon runAction:[CCRepeatForever actionWithAction:rotSeq]];
}

-(id)initWithLevel16UILayer:(UILayer *)level16UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [FlurryAnalytics logEvent:@"Level 16 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 30;
   
        [self setupBackground];
        uiLayer = level16UILayer;
        
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
        
        
        
        
        
        
        
        //penguin
        [self createPenguin2AtLocation:ccp(winSize.width * 1.15f, winSize.height * 0.2f)];
        
        //Ice Block
        CCSprite *iceBlock = [CCSprite spriteWithSpriteFrameName:@"iceblock.png"];
        iceBlock.position = ccp(winSize.width * 1.15f,winSize.height * .1f);
        [self addChild:iceBlock z:kNegTwoZValue];
        
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        CCMoveTo *mov = [CCMoveTo actionWithDuration:30 position:ccp(winSize.width * -0.25f,winSize.height * .2f)];
        //The tag is needed to detect 
        mov.tag = kMoveActionTag;
        
        [penguin2 runAction:mov];
        [iceBlock runAction:[CCMoveTo actionWithDuration:30 position:ccp(winSize.width * -0.25f,winSize.height * .1f)]];
        
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.2 angle:-1.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.2 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.2 angle:1.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [iceBlock runAction:[CCRepeatForever actionWithAction:rotSeq]]; 
        
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //[self schedule:@selector(addBalloons) interval:2];
        //create trash every so often
        [self schedule:@selector(addTrash) interval:5];
        
        //Add snow
//        CCParticleSystem *snowParticleSystem = [CCParticleSnow node];
//        [self addChild:snowParticleSystem];
        
    }
    return self;
}


@end
