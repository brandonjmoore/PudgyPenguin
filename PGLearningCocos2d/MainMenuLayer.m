//
//  MainMenuLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "MainMenuLayer.h"

@interface MainMenuLayer ()
-(void)displayMainMenu;
-(void)displaySceneSelection;
@end

@implementation MainMenuLayer

-(void)showOptions {
    CCLOG(@"Show the options screen");
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}

-(void)playScene:(CCMenuItemFont*)itemPassedIn {
    if ([itemPassedIn tag] == 1) {
        CCLOG(@"Tag 1 found, Scene 1");
        [[GameManager sharedGameManager] runSceneWithID:kIntroScene];
    }
    if ([itemPassedIn tag] == 2) {
        CCLOG(@"Tag 2 found, Scene 2");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel2];
    }
    if ([itemPassedIn tag] == 3) {
        CCLOG(@"Tag 3 found, Scene 3");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel3];
    } 
    else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
        CCLOG(@"Placeholder for next chapters");
    }
}

-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (sceneSelectMenu1 != nil) {
        [sceneSelectMenu1 removeFromParentAndCleanup:YES];
    }
    if (sceneSelectMenu2 != nil) {
        [sceneSelectMenu2 removeFromParentAndCleanup:YES];
    }
    if (sceneSelectMenu3 != nil) {
        [sceneSelectMenu3 removeFromParentAndCleanup:YES];
    }
    if (backButtonMenu != nil) {
        [backButtonMenu removeFromParentAndCleanup:YES];
    }
    
    [self removeChild:background cleanup:YES];
    
    background = [CCSprite spriteWithFile:@"MainMenuBG.png"];
    [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild:background];
    
    //Main Menu
    //Main Menu
    CCSprite *startButtonNormal = [CCSprite spriteWithSpriteFrameName:@"PlayGameButtonNormal.png"];
    CCSprite *startButtonSelected = [CCSprite spriteWithSpriteFrameName:@"PlayGameButtonSelected.png"];
    
    
    CCMenuItemSprite *playGameButton = [CCMenuItemSprite itemFromNormalSprite:startButtonNormal selectedSprite:startButtonSelected disabledSprite:nil target:self selector:@selector(displaySceneSelection)];
    
    mainMenu = [CCMenu menuWithItems:playGameButton, nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [mainMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height/2)];

    [self addChild:mainMenu z:0 tag:kButtonTagValue];
                                      
}

-(void)displaySceneSelection {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (mainMenu != nil) {
        [mainMenu removeFromParentAndCleanup:YES];
    }
    
    [self removeChild:background cleanup:YES];
    
    background = [CCSprite spriteWithFile:@"background.png"];
    [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild:background];
    
    CCSprite *disabledSprite1 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite2 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite3 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite4 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite5 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite6 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite7 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite8 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite9 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite10 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite11 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
    CCSprite *disabledSprite12 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];

    
    CCSprite *levelOneButtonNormal = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonNormal.png"];
    CCSprite *levelOneButtonSelected = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonSelected.png"];
    
    CCSprite *level2ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"Scene2ButtonNormal.png"];
    CCSprite *level2ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"Scene2ButtonSelected.png"];
    
    CCSprite *level3ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_3.png"];
    CCSprite *level3ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_3_over.png"];
    
    CCSprite *level4ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_4.png"];
    CCSprite *level4ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_4_over.png"];
    
    CCSprite *level5ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_5.png"];
    CCSprite *level5ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_5_over.png"];
    
    CCSprite *level6ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_6.png"];
    CCSprite *level6ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_6_over.png"];
    
    CCSprite *level7ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_7.png"];
    CCSprite *level7ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_7_over.png"];
    
    CCSprite *level8ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_8.png"];
    CCSprite *level8ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_8_over.png"];
    
    CCSprite *level9ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_9.png"];
    CCSprite *level9ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_9_over.png"];
    
    CCSprite *level10ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_10.png"];
    CCSprite *level10ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_10_over.png"];
    
    CCSprite *level11ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_11.png"];
    CCSprite *level11ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_11_over.png"];
    
    CCSprite *level12ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_12.png"];
    CCSprite *level12ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"lvl_12_over.png"];
    
    
    CCMenuItemSprite *playLevel1Button = [CCMenuItemSprite itemFromNormalSprite:levelOneButtonNormal selectedSprite:levelOneButtonSelected disabledSprite:disabledSprite1 target:self selector:@selector(playScene:)];
    [playLevel1Button setTag:1];
    
    playLevel1Button.isEnabled = YES;
    
    CCMenuItemSprite *playLevel2Button = [CCMenuItemSprite itemFromNormalSprite:level2ButtonNormal selectedSprite:level2ButtonSelected disabledSprite:disabledSprite2 target:self selector:@selector(playScene:)];
    [playLevel2Button setTag:2];
    
    playLevel2Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level2unlocked"];
    
    CCMenuItemSprite *playLevel3Button = [CCMenuItemSprite itemFromNormalSprite:level3ButtonNormal selectedSprite:level3ButtonSelected disabledSprite:disabledSprite3 target:self selector:@selector(playScene:)];
    [playLevel3Button setTag:3];
    
    playLevel3Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level3unlocked"];
    
    CCMenuItemSprite *playLevel4Button = [CCMenuItemSprite itemFromNormalSprite:level4ButtonNormal selectedSprite:level4ButtonSelected disabledSprite:disabledSprite4 target:self selector:@selector(playScene:)];
    [playLevel4Button setTag:4];
    
    playLevel4Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level4unlocked"];
    
    CCMenuItemSprite *playLevel5Button = [CCMenuItemSprite itemFromNormalSprite:level5ButtonNormal selectedSprite:level5ButtonSelected disabledSprite:disabledSprite5 target:self selector:@selector(playScene:)];
    [playLevel5Button setTag:5];
    
    playLevel5Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level5unlocked"];
    
    CCMenuItemSprite *playLevel6Button = [CCMenuItemSprite itemFromNormalSprite:level6ButtonNormal selectedSprite:level6ButtonSelected disabledSprite:disabledSprite6 target:self selector:@selector(playScene:)];
    [playLevel6Button setTag:6];
    
    playLevel6Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level6unlocked"];
    
    CCMenuItemSprite *playLevel7Button = [CCMenuItemSprite itemFromNormalSprite:level7ButtonNormal selectedSprite:level7ButtonSelected disabledSprite:disabledSprite7 target:self selector:@selector(playScene:)];
    [playLevel7Button setTag:7];
   
    playLevel7Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level7unlocked"];
    
    CCMenuItemSprite *playLevel8Button = [CCMenuItemSprite itemFromNormalSprite:level8ButtonNormal selectedSprite:level8ButtonSelected disabledSprite:disabledSprite8 target:self selector:@selector(playScene:)];
    [playLevel8Button setTag:8];
    
    playLevel8Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level8unlocked"];
    
    CCMenuItemSprite *playLevel9Button = [CCMenuItemSprite itemFromNormalSprite:level9ButtonNormal selectedSprite:level9ButtonSelected disabledSprite:disabledSprite9 target:self selector:@selector(playScene:)];
    [playLevel9Button setTag:9];
    
    playLevel9Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level9unlocked"];
    
    CCMenuItemSprite *playLevel10Button = [CCMenuItemSprite itemFromNormalSprite:level10ButtonNormal selectedSprite:level10ButtonSelected disabledSprite:disabledSprite10 target:self selector:@selector(playScene:)];
    [playLevel10Button setTag:10];
    
    playLevel10Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level10unlocked"];
    
    CCMenuItemSprite *playLevel11Button = [CCMenuItemSprite itemFromNormalSprite:level11ButtonNormal selectedSprite:level11ButtonSelected disabledSprite:disabledSprite11 target:self selector:@selector(playScene:)];
    [playLevel11Button setTag:11];
    
    playLevel11Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level11unlocked"];
    
    CCMenuItemSprite *playLevel12Button = [CCMenuItemSprite itemFromNormalSprite:level12ButtonNormal selectedSprite:level12ButtonSelected disabledSprite:disabledSprite12 target:self selector:@selector(playScene:)];
    [playLevel12Button setTag:12];
    
    playLevel12Button.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"level12unlocked"];
    
    
    
    sceneSelectMenu1 = [CCMenu menuWithItems:playLevel1Button, playLevel2Button, playLevel3Button, playLevel4Button, nil];
    sceneSelectMenu2 = [CCMenu menuWithItems:playLevel5Button, playLevel6Button, playLevel7Button, playLevel8Button, nil];
    sceneSelectMenu3 = [CCMenu menuWithItems:playLevel9Button, playLevel10Button, playLevel11Button, playLevel12Button, nil];
    
    
    [sceneSelectMenu1 alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
    [sceneSelectMenu2 alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
    [sceneSelectMenu3 alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
    
    [sceneSelectMenu1 setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.75f)];
    [sceneSelectMenu2 setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.6f)];
    [sceneSelectMenu3 setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.45f)];
    
    [self addChild:sceneSelectMenu1 z:1 tag:kButtonTagValue];
    [self addChild:sceneSelectMenu2 z:1 tag:kButtonTagValue];
    [self addChild:sceneSelectMenu3 z:1 tag:kButtonTagValue];
    
    
    
    
    //Set up the back button
    CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
    CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(displayMainMenu)];
    [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
    
    backButtonMenu = [CCMenu menuWithItems:backButton, nil];
    
    [backButtonMenu setPosition:ccp(0,0)];
    [self addChild:backButtonMenu z:1 tag:kButtonTagValue];
    //[disabledSprite setPosition:ccp(screenSize.width *0.5f, screenSize.height * 0.5f)];
    //[self addChild:disabledSprite];
    
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSpriteBatchNode *mainMenuSpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        mainMenuSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        
        background = [CCSprite spriteWithFile:@"MainMenuBG.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        //Add the buttons to the screen
        [self displayMainMenu];
        
        
    }
    
    return self;
}

@end
