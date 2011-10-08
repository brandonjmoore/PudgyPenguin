//
//  IntroLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "IntroLayer.h"

@interface IntroLayer ()
-(void)displayIntroMenu;
@end

@implementation IntroLayer

-(void)startGamePlay {
	CCLOG(@"Intro complete, asking Game Manager to start the Game play");
	[[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
}

-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //TODO: delete this if statement when sure that it is not needed
//    if (sceneSelectMenu != nil) {
//        [sceneSelectMenu removeFromParentAndCleanup:YES];
//    }
    
    //Main Menu
    CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"StartButtonNormal.png" selectedImage:@"StartButtonSelected.png" disabledImage:nil target:self selector:@selector(startGamePlay)];
    introMenu = [CCMenu menuWithItems:startButton, nil];
    [introMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [introMenu setPosition:ccp(screenSize.width * 2, screenSize.height /2)];
    
    id moveAction = [CCMoveTo actionWithDuration:1.2f position:ccp(screenSize.width * 0.85f, screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [introMenu runAction:moveEffect];
    [self addChild:introMenu z:0 tag:kIntroMenuTagValue];
    
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Create the intro image
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCSprite *introImage = [CCSprite spriteWithFile:@"intro1.png"];
		[introImage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:introImage];
    }
    
    return self;
}

@end
