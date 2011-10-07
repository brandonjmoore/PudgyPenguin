//
//  MainMenuLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "MainMenuLayer.h"

@interface MainMenuLayer ()
-(void)displayMenu;
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
    
    id moveAction = [CCMoveTo actionWithDuration:1.2f position:ccp(screenSize.width * 0.85f, screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [mainMenu runAction:moveEffect];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
                                      
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Initialization code here.
    }
    
    return self;
}

@end
