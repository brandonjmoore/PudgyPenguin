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
    } else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
        CCLOG(@"Placeholder for next chapters");
    }
}

-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (sceneSelectMenu != nil) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    
    //Main Menu
    CCMenuItemImage *playGameButton = [CCMenuItemImage itemFromNormalImage:@"PlayGameButtonNormal.png" selectedImage:@"PlayGameButtonSelected.png" disabledImage:nil target:self selector:@selector(displaySceneSelection)];
    
    CCMenuItemImage *optionsButton = [CCMenuItemImage itemFromNormalImage:@"OptionsButtonNormal.png" selectedImage:@"OptionsButtonSelected.png" disabledImage:nil target:self selector:@selector(showOptions)];
    
    mainMenu = [CCMenu menuWithItems:playGameButton, optionsButton, nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [mainMenu setPosition:ccp(screenSize.width * 2, screenSize.height /2)];
    
    id moveAction = [CCMoveTo actionWithDuration:1.2f position:ccp(screenSize.width * 0.5f, screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [mainMenu runAction:moveEffect];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
                                      
}

-(void)displaySceneSelection {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (mainMenu != nil) {
        [mainMenu removeFromParentAndCleanup:YES];
    }
    
    //CCLabelBMFont *playScene1Label = [CCLabelBMFont labelWithString:@"Level 1!" fntFile:@"Helvetica"
    //Using CCMenuItemImages instead of CCMenuItemLabels (page 187)
    CCMenuItemImage *playScene1Button = [CCMenuItemImage itemFromNormalImage:@"Scene1ButtonNormal.png" selectedImage:@"Scene1ButtonSelected.png" disabledImage:nil target:self selector:@selector(playScene:)];
    [playScene1Button setTag:1];
    
    CCMenuItemImage *playScene2Button = [CCMenuItemImage itemFromNormalImage:@"Scene2ButtonNormal.png" selectedImage:@"Scene2ButtonSelected.png" disabledImage:nil target:self selector:@selector(playScene:)];
    [playScene2Button setTag:2];
    
    CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"BackButtonNormal.png" selectedImage:@"BackButtonSelected.png" disabledImage:nil target:self selector:@selector(displayMainMenu:)];
    
    sceneSelectMenu = [CCMenu menuWithItems:playScene1Button, playScene2Button, backButton, nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5f position:ccp(screenSize.width * 0.75f, screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [sceneSelectMenu runAction:moveEffect];
    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
    
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        //Add the buttons to the screen
        [self displayMainMenu];
        
        CCSprite *penguin = [CCSprite spriteWithFile:@"PenguinIdle.png"];
        [penguin setPosition:ccp(screenSize.width * 0.8f, screenSize.height * 0.2f)];
        [self addChild:penguin];
        
    }
    
    return self;
}

@end
