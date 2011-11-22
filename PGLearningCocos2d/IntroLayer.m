//
//  IntroLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//
#import "IntroLayer.h"

@implementation IntroLayer
-(void)startGamePlay {
	CCLOG(@"Intro complete, asking Game Manager to start the Game play");
	[[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CCLOG(@"Touches received, skipping intro");
	[self startGamePlay];
}


-(id)init {
	self = [super init];
	if (self != nil) {
		// Accept touch input
		self.isTouchEnabled = YES;
		
		// Create the intro image
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCSprite *introImage = [CCSprite spriteWithFile:@"instructions_screen.png"];
		[introImage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:introImage];
	}
	return self;
}
@end
