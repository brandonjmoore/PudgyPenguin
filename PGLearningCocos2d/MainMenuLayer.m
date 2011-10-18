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
        //Placeholder for level 2
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
    CCMenuItemImage *playGameButton = [CCMenuItemImage itemFromNormalImage:@"PlayGameButtonNormal.png" selectedImage:@"PlayGameButtonSelected.png" disabledImage:nil target:self selector:@selector(displaySceneSelection)];
    
    CCMenuItemImage *optionsButton = [CCMenuItemImage itemFromNormalImage:@"OptionsButtonNormal.png" selectedImage:@"OptionsButtonSelected.png" disabledImage:nil target:self selector:@selector(showOptions)];
    
    mainMenu = [CCMenu menuWithItems:playGameButton, optionsButton, nil];
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
    
    
    CCMenuItemSprite *playLevel1Button = [CCMenuItemSprite itemFromNormalSprite:levelOneButtonNormal selectedSprite:levelOneButtonSelected disabledSprite:nil target:self selector:@selector(playScene:)];
    [playLevel1Button setTag:1];
    
    
    sceneSelectMenu = [CCMenu menuWithItems:playLevel1Button, nil];
    
    
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
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        //Add the buttons to the screen
        [self displayMainMenu];
        
        CCSprite *penguin = [CCSprite spriteWithSpriteFrameName:@"PenguinIdle.png"];
        [penguin setPosition:ccp(screenSize.width * 0.8168f, screenSize.height * 0.215f)];
        
        [mainMenuSpriteBatchNode addChild:penguin];
        
        [self addChild:mainMenuSpriteBatchNode];
        
    }
    
    return self;
}

@end
