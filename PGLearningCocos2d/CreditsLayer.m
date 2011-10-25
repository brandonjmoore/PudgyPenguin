//
//  CreditsLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "CreditsLayer.h"


@implementation CreditsLayer

-(void)returnToOptionMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
}


-(id)init {
	self = [super init];
	if (self != nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize; 
		CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
		
		
		CCLabelTTF *brandonText = [CCLabelTTF labelWithString:@"Programming: Brandon Moore" fontName:@"Marker Felt" fontSize:20.0];

		CCLabelTTF *jonathanText = [CCLabelTTF labelWithString:@"Programming and Art: Jonathan Urie" fontName:@"Marker Felt" fontSize:20.0];
        
		CCLabelTTF *andyText = [CCLabelTTF labelWithString:@"Music: Andy Thomas" fontName:@"Marker Felt" fontSize:20.0];
        
        CCLabelTTF *byuText = [CCLabelTTF labelWithString:@"A Special Thanks to" fontName:@"Marker Felt" fontSize:16.0];
        CCLabelTTF *byuText2 = [CCLabelTTF labelWithString:@"The BYU Mobile App Competition" fontName:@"Marker Felt" fontSize:16.0];
        
        CCLabelTTF *cocos2dText = [CCLabelTTF labelWithString:@"Made with Cocos2d and Box2d" fontName:@"Marker Felt" fontSize:16.0];
        
        brandonText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.85f);
        jonathanText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.8f);
        andyText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.75f);
		byuText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.70f);
        byuText2.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.66f);
        cocos2dText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.05f);
		
		
		//Set up the back button
        CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
        CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(returnToOptionMenu)];
        [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
        
        backButtonMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backButtonMenu setPosition:ccp(0,0)];
        [self addChild:backButtonMenu z:1 tag:kButtonTagValue];
                                   
		
		[self addChild:brandonText];
        [self addChild:jonathanText];
        [self addChild:andyText];
        [self addChild:byuText];
        [self addChild:byuText2];
        [self addChild:cocos2dText];
		
		
	}
	return self;
}

@end
