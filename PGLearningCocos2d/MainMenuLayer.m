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
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
    }
    if ([itemPassedIn tag] == 2) {
        CCLOG(@"Tag 2 found, Scene 2");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel2];
    } 
    else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
        CCLOG(@"Placeholder for next chapters");
    }
}

-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (sceneSelectMenu != nil) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    if (backButtonMenu != nil) {
        [backButtonMenu removeFromParentAndCleanup:YES];
    }
    
    
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
    
    CCSprite *levelOneButtonNormal = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonNormal.png"];
    CCSprite *levelOneButtonSelected = [CCSprite spriteWithSpriteFrameName:@"Scene1ButtonSelected.png"];
    
    CCSprite *level2ButtonNormal = [CCSprite spriteWithSpriteFrameName:@"Scene2ButtonNormal.png"];
    CCSprite *level2ButtonSelected = [CCSprite spriteWithSpriteFrameName:@"Scene2ButtonSelected.png"];
    
    CCSprite *disablesSprite = [CCSprite spriteWithFile:@"snow.png"];
    
    
    CCMenuItemSprite *playLevel1Button = [CCMenuItemSprite itemFromNormalSprite:levelOneButtonNormal selectedSprite:levelOneButtonSelected disabledSprite:disablesSprite target:self selector:@selector(playScene:)];
    [playLevel1Button setTag:1];
    
    playLevel1Button.isEnabled = NO;
    
    CCMenuItemSprite *playLevel2Button = [CCMenuItemSprite itemFromNormalSprite:level2ButtonNormal selectedSprite:level2ButtonSelected disabledSprite:nil target:self selector:@selector(playScene:)];
    [playLevel2Button setTag:2];
    
    
    sceneSelectMenu = [CCMenu menuWithItems:playLevel1Button, playLevel2Button, nil];
    
    
    [sceneSelectMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.75f)];
    
    [self addChild:sceneSelectMenu z:1 tag:kButtonTagValue];
    
    
    
    
    //Set up the back button
    CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
    CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(displayMainMenu)];
    [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
    
    backButtonMenu = [CCMenu menuWithItems:backButton, nil];
    
    [backButtonMenu setPosition:ccp(0,0)];
    [self addChild:backButtonMenu z:1 tag:kButtonTagValue];
    
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSpriteBatchNode *mainMenuSpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        mainMenuSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        
        CCSprite *background = [CCSprite spriteWithFile:@"MainMenuBG.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        //Add the buttons to the screen
        [self displayMainMenu];
        
        
    }
    
    return self;
}

@end
