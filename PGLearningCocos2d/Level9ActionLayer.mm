//
//  Level9ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level9ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"

@implementation Level9ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * 0.15, screenSize.height * 1.05f)];
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
            [self createTrashAtLocation:ccp(screenSize.width * 0.8, screenSize.height * 0.95)];
            
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel9];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    //This is only needed if you are pausing the shared director when they complete the level
    //[[CCDirector sharedDirector] resume];
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel10];
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCSprite *backgroundImage;
    backgroundImage = [CCSprite spriteWithFile:@"snow_bg.png"];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
    
    [self addChild:backgroundImage z:-10 tag:0];
}

-(void)doHighScoreStuff {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //Get app delegate (used for high scores)
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    //Show level High Score (new high scores only)
    if (remainingTime > [app getHighScoreForLevel:kLevel9]) {
        NSString *levelHighScoreText = [NSString stringWithFormat:@"New High Score!"];
        CCLabelTTF *levelHighScoreLabel = [CCLabelTTF labelWithString:levelHighScoreText fontName:@"Marker Felt" fontSize:24.0];
        levelHighScoreLabel.position = ccp(winSize.width * 0.5f, winSize.height * 0.25f);
        [self addChild:levelHighScoreLabel z:10];
    }
    
    
    //Set the High Score (if new value is greater than old value)
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel9];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel9];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 9 high score: %d", levelHighScore];
    CCLabelTTF *levelScoreText = [CCLabelTTF labelWithString:levelScoreString fontName:@"Marker Felt" fontSize:16.0];
    levelScoreText.position = ccp(winSize.width * 0.5f, winSize.height * 0.1f);
    [self addChild:levelScoreText z:10];
    
    
    //Show total high score
    NSInteger totalHighScore = [app getTotalHighScore];
    
    NSString *highScoreString = [NSString stringWithFormat:@"Total high score: %d", totalHighScore];
    CCLabelTTF *highScoreText = [CCLabelTTF labelWithString:highScoreString fontName:@"Marker Felt" fontSize:16.0];
    highScoreText.position = ccp(winSize.width * 0.5f, winSize.height * 0.05f);
    [self addChild:highScoreText z:10];
}

-(void) gameOverPass: (id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level10unlocked"];
    
    //So that fish dont bounce forever
    //[[CCDirector sharedDirector] pause];
    
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    self.isTouchEnabled = NO;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayerColor *levelCompleteLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:levelCompleteLayer z:9];
    
    CCSprite *nextLevelButtonNormal = [CCSprite spriteWithSpriteFrameName:@"next_button.png"];
    CCSprite *nextLevelButtonSelected = [CCSprite spriteWithSpriteFrameName:@"next_button_over.png"];
    
    CCMenuItemSprite *nextLevelButton = [CCMenuItemSprite itemFromNormalSprite:nextLevelButtonNormal selectedSprite:nextLevelButtonSelected disabledSprite:nil target:self selector:@selector(doNextLevel)];
    
    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
    
    CCMenu *nextLevelMenu = [CCMenu menuWithItems:nextLevelButton, mainMenuButton, resetButton, nil];
    [nextLevelMenu alignItemsVerticallyWithPadding:winSize.height * 0.04f];
    [nextLevelMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
    [self addChild:nextLevelMenu z:10];
    
    [self doHighScoreStuff];
    
}

-(id)initWithLevel9UILayer:(UILayer *)level9UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [FlurryAnalytics logEvent:@"Level 9 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 31;
   
        [self setupBackground];
        uiLayer = level9UILayer;
        
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

        [self createBoxAtLocation:ccp(winSize.width * 0.8f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        [self createBoxAtLocation:ccp(winSize.width * 0.65f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];        
        [self createBoxAtLocation:ccp(winSize.width * 0.5f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        [self createBoxAtLocation:ccp(winSize.width * 0.35f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        [self createBoxAtLocation:ccp(winSize.width * 0.2f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        [self createBoxAtLocation:ccp(winSize.width * 0.05f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        
        [self createPlatformAtLocation:ccp(winSize.width * 0.93f, winSize.height *0.72f) ofType:kSmallPlatform withRotation:4.7];
        [self createPlatformAtLocation:ccp(winSize.width * 0.23f, winSize.height *0.8f) ofType:kLargePlatform withRotation:0.0];
        
        
        [self createPenguin2AtLocation:ccp(winSize.width * 0.9f, winSize.height * 0.8f)];
        
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

@end
