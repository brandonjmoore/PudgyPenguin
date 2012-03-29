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
            [self createFish2AtLocation:ccp(screenSize.width * 0.2f, screenSize.height * 1.05f)];
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel16];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    //[[GameManager sharedGameManager] runSceneWithID:kGameLevel16];
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCSprite *backgroundImage;
    backgroundImage = [CCSprite spriteWithFile:@"ocean_no_block.png"];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
    
    [self addChild:backgroundImage z:-10 tag:0];
}

-(void)doHighScoreStuff {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //Get app delegate (used for high scores)
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    //Show level High Score (new high scores only)
    if (remainingTime > [app getHighScoreForLevel:kLevel16]) {
        NSString *levelHighScoreText = [NSString stringWithFormat:@"New High Score!"];
        CCLabelTTF *levelHighScoreLabel = [CCLabelTTF labelWithString:levelHighScoreText fontName:@"Marker Felt" fontSize:24.0];
        levelHighScoreLabel.position = ccp(winSize.width * 0.5f, winSize.height * 0.25f);
        [self addChild:levelHighScoreLabel z:10];
    }
    
    
    //Set the High Score (if new value is greater than old value)
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel16];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel16];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 17 high score: %d", levelHighScore];
    CCLabelTTF *levelScoreText = [CCLabelTTF labelWithString:levelScoreString fontName:@"Marker Felt" fontSize:16.0];
    levelScoreText.position = ccp(winSize.width * 0.48f, winSize.height * 0.1f);
    [self addChild:levelScoreText z:10];
    
    
    //Show total high score
    NSInteger totalHighScore = [app getTotalHighScore];
    
    NSString *highScoreString = [NSString stringWithFormat:@"Total high score: %d", totalHighScore];
    CCLabelTTF *highScoreText = [CCLabelTTF labelWithString:highScoreString fontName:@"Marker Felt" fontSize:16.0];
    highScoreText.position = ccp(winSize.width * 0.48f, winSize.height * 0.05f);
    [self addChild:highScoreText z:10];
}

-(void) gameOverPass: (id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level17unlocked"];
    
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    self.isTouchEnabled = NO;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayerColor *levelCompleteLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:levelCompleteLayer z:9];

    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    //CCSprite *nextLevelButtonNormal = [CCSprite spriteWithSpriteFrameName:@"next_button.png"];
    //CCSprite *nextLevelButtonSelected = [CCSprite spriteWithSpriteFrameName:@"next_button_over.png"];
    
    //CCMenuItemSprite *nextLevelButton = [CCMenuItemSprite itemFromNormalSprite:nextLevelButtonNormal selectedSprite:nextLevelButtonSelected disabledSprite:nil target:self selector:@selector(doNextLevel)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
   
    CCMenu *nextLevelMenu = [CCMenu menuWithItems:mainMenuButton, resetButton, nil];
    [nextLevelMenu alignItemsVerticallyWithPadding:winSize.height * 0.04f];
    [nextLevelMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
    [self addChild:nextLevelMenu z:10];
    
    [self doHighScoreStuff];
    
}

-(void)moveBox{
    myBody->SetLinearVelocity(b2Vec2(1.0f, 0.0f));
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
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        [self addChild:sceneSpriteBatchNode z:-1];
        
        
        
        
        
        
        
        //penguin
        [self createPenguin2AtLocation:ccp(winSize.width * 1.15f, winSize.height * 0.2f)];
        
        //Ice Block
        CCSprite *iceBlock = [CCSprite spriteWithFile:@"iceblock.png"];
        iceBlock.position = ccp(winSize.width * 1.15f,winSize.height * .1f);
        [self addChild:iceBlock z:kNegTwoZValue];
        
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        penguin2.body->SetLinearVelocity(b2Vec2(-1.0f, 0.0f));
        [iceBlock runAction:[CCMoveTo actionWithDuration:VEL_TO_SEC(1.3,-1) position:ccp(winSize.width * -0.15f,winSize.height * .1f)]];
        
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.2 angle:-1.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.2 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.2 angle:1.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [iceBlock runAction:[CCRepeatForever actionWithAction:rotSeq]]; 
        
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //create trash every so often
        //[self schedule:@selector(addTrash) interval:kTimeBetweenTrashCreation];
        
        //Add snow
        CCParticleSystem *snowParticleSystem = [CCParticleSnow node];
        [self addChild:snowParticleSystem];
        
    }
    return self;
}


@end
