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
		CCSprite *background;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            background = [CCSprite spriteWithFile:@"ocean_no_block_iPad.png"];
        }else {
            background = [CCSprite spriteWithFile:@"ocean_no_block.png"];
        }
        
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
		
		
//		CCLabelBMFont *brandonText = [CCLabelBMFont labelWithString:@"Programming: Brandon Moore" fntFile:kFONT];
//        
//        [brandonText setScale:.67];
//        
//		CCLabelBMFont *jonathanText = [CCLabelBMFont labelWithString:@"Programming and Art: Jonathan Urie" fntFile:kFONT];
//        
//		CCLabelBMFont *andyText = [CCLabelBMFont labelWithString:@"Music: Andy Thomas" fntFile:kFONT];
//        
//        CCLabelBMFont *alexText = [CCLabelBMFont labelWithString:@"Conceptual Design: Alex Sherrick" fntFile:kFONT];
//        
//        CCLabelBMFont *byuText = [CCLabelBMFont labelWithString:@"A Special Thanks to" fntFile:kFONT];
//        CCLabelBMFont *byuText2 = [CCLabelBMFont labelWithString:@"The BYU Mobile App Competition" fntFile:kFONT];
//        
//        CCLabelBMFont *cocos2dText = [CCLabelBMFont labelWithString:@"Made with Cocos2d and Box2d" fntFile:kFONT];
//        CCLabelBMFont *nounproject = [CCLabelBMFont labelWithString:@"Clock by Taylor Medlin, from The Noun Project" fntFile:kFONT];
//        
//        brandonText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.85f);
//        jonathanText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.8f);
//        alexText.position = ccp(screenSize.width * 0.5, screenSize.height * 0.75f);
//        andyText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.7f);
//		byuText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.65f);
//        byuText2.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.61f);
//        cocos2dText.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.05f);
//        nounproject.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.01f);
		
		
		//Set up the back button
        CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
        CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(returnToOptionMenu)];
        [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
        
        backButtonMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backButtonMenu setPosition:ccp(0,0)];
        [self addChild:backButtonMenu z:1 tag:kButtonTagValue];
                                   
		
//		[self addChild:brandonText];
//        [self addChild:jonathanText];
//        [self addChild:alexText];
//        [self addChild:andyText];
//        [self addChild:byuText];
//        [self addChild:byuText2];
//        [self addChild:cocos2dText];
//        [self addChild:nounproject];
		
		
	}
	return self;
}

@end
