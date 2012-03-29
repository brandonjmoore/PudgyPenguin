//
//  Level13ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level13ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"

@implementation Level13ActionLayer


#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * 0.2, screenSize.height * 1.05)];
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel13];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel14];
}

#pragma mark -
#pragma mark Facebook Stuff

-(void)doFacebookStuff {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: 
                                       kFacebookAppID, @"app_id", 
                                       @"http://itunes.apple.com/us/app/pudgy-penguin/id475771110?ls=1&mt=8#", @"link", 
                                       @"http://a1.mzstatic.com/us/r1000/116/Purple/cb/e5/08/mzl.jgtgkwba.175x175-75.jpg", @"picture", 
                                       @"Pudgy Penguin!!!", @"name", 
                                       @"New High Score!", @"caption", 
                                       [NSString stringWithFormat:@"I just threw down %i points in Pudgy Penguin! What's your high score?", [app getTotalHighScore]], @"description", 
                                       @"And boom goes the dynamite!",  @"message", nil];
    [app doFacebookStuff:params];
}

//// Pre 4.2 support
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    
//    return [facebook handleOpenURL:url]; 
//}
//
//// For 4.2+ support
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [facebook handleOpenURL:url]; 
//}

//- (void)fbDidLogin {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
//    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
//    [defaults synchronize];
//    
//    
//}

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
    
    
    //Show level High Score (new high scores only)
    if (remainingTime > [app getHighScoreForLevel:kLevel13]) {
        NSString *levelHighScoreText = [NSString stringWithFormat:@"New High Score!"];
        CCLabelTTF *levelHighScoreLabel = [CCLabelTTF labelWithString:levelHighScoreText fontName:@"Marker Felt" fontSize:24.0];
        levelHighScoreLabel.position = ccp(winSize.width * 0.5f, winSize.height * 0.25f);
        [self addChild:levelHighScoreLabel z:10];
    }
    
    
    //Set the High Score (if new value is greater than old value)
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel13];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel13];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 13 high score: %d", levelHighScore];
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
    [defaults setBool:YES forKey:@"level14unlocked"];
    
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    self.isTouchEnabled = NO;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayerColor *levelCompleteLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:levelCompleteLayer z:9];

    CCSprite *mainMenuButtonNormal = [CCSprite spriteWithSpriteFrameName:@"menu.png"];
    CCSprite *mainMenuButtonSelected = [CCSprite spriteWithSpriteFrameName:@"menu_over.png"];
    
    CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:mainMenuButtonNormal selectedSprite:mainMenuButtonSelected disabledSprite:nil target:self selector:@selector(doReturnToMainMenu)];
    
    CCSprite *facebookButton = [CCSprite spriteWithFile:@"Facebook.png"];
    
    CCMenuItemSprite *facebookMenuItem = [CCMenuItemSprite itemFromNormalSprite:facebookButton selectedSprite:nil disabledSprite:nil target:self selector:@selector(doFacebookStuff)];
    
    CCMenu *facebookMenu = [CCMenu menuWithItems:facebookMenuItem, nil];
    [facebookMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
    [self addChild:facebookMenu];
    
    //CCSprite *nextLevelButtonNormal = [CCSprite spriteWithSpriteFrameName:@"next_button.png"];
    //CCSprite *nextLevelButtonSelected = [CCSprite spriteWithSpriteFrameName:@"next_button_over.png"];
    
    //CCMenuItemSprite *nextLevelButton = [CCMenuItemSprite itemFromNormalSprite:nextLevelButtonNormal selectedSprite:nextLevelButtonSelected disabledSprite:nil target:self selector:@selector(doNextLevel)];
    
    CCSprite *resetButtonNormal = [CCSprite spriteWithSpriteFrameName:@"reset.png"];
    CCSprite *resetButtonSelected = [CCSprite spriteWithSpriteFrameName:@"reset_over.png"];
    
    CCMenuItemSprite *resetButton = [CCMenuItemSprite itemFromNormalSprite:resetButtonNormal selectedSprite:resetButtonSelected disabledSprite:nil target:self selector:@selector(doResetLevel)];
   
    //CCMenu *nextLevelMenu = [CCMenu menuWithItems:nextLevelButton, mainMenuButton, resetButton, nil];
    CCMenu *nextLevelMenu = [CCMenu menuWithItems:mainMenuButton, resetButton, nil];
    [nextLevelMenu alignItemsHorizontallyWithPadding:winSize.width * 0.04f];
    [nextLevelMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.2f)];
    [self addChild:nextLevelMenu z:10];
    
    
    [self doHighScoreStuff];
    
}

-(id)initWithLevel13UILayer:(UILayer *)level13UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [FlurryAnalytics logEvent:@"Level 13 Started"];
        
        //Get app delegate (used for high scores and Facebook)
        app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 30;
   
        [self setupBackground];
        uiLayer = level13UILayer;
        
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
        
        [self createPenguin2AtLocation:ccp(winSize.width * 0.9f, winSize.height * 0.8f)];
        
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        
        [self createBoxAtLocation:ccp(winSize.width * 0.8f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        
        [self createBoxAtLocation:ccp(winSize.width * 0.65f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];        
        [self createBoxAtLocation:ccp(winSize.width * 0.5f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        
        [self createBoxAtLocation:ccp(winSize.width * 0.35f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        [self createBoxAtLocation:ccp(winSize.width * 0.2f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        
        [self createPlatformAtLocation:ccp(winSize.width * 0.125f, winSize.height * 0.1f) ofType:kMediumPlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.125f, winSize.height * 0.65f) ofType:kExtraExtraLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.275f, winSize.height * 0.1f) ofType:kLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.275f, winSize.height * 0.7f) ofType:kExtraLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.425f, winSize.height * 0.2f) ofType:kLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.425f, winSize.height * 0.8f) ofType:kExtraLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.575f, winSize.height * 0.25f) ofType:kExtraLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.575f, winSize.height * 0.85f) ofType:kLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.725f, winSize.height * 0.3f) ofType:kExtraExtraLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.725f, winSize.height * 0.95f) ofType:kLargePlatform withRotation:0.0f];
 
        [self createPlatformAtLocation:ccp(winSize.width * 0.4f, winSize.height * 1.5f) ofType:kExtraExtraLargePlatform withRotation:1.0f];

        [self createPlatformAtLocation:ccp(winSize.width * 0.93f, winSize.height *0.72f) ofType:kSmallPlatform withRotation:4.7];
        
        
        
        
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
