//
//  MoreInfoLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "MoreInfoLayer.h"
#import "AppDelegate.h"
#import "GCHelper.h"



@implementation MoreInfoLayer

#pragma mark -
#pragma mark Switch Menus

-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}
-(void)showCredits {
	[[GameManager sharedGameManager] runSceneWithID:kCreditsScene];
}

-(void)showHighScores {
	[[GameManager sharedGameManager] runSceneWithID:kHighScoresScene];
}

#pragma mark -
#pragma mark Game Center

-(void)showGameCenter {
	GKLeaderboardViewController *leaderBoardController = [[GKLeaderboardViewController alloc] init];
    
    
    if (leaderBoardController != NULL) {
        leaderBoardController.category = kLeaderBoardCompletionTime;
        leaderBoardController.timeScope = GKLeaderboardTimeScopeAllTime;
        leaderBoardController.leaderboardDelegate = self;
        //Get app delegate (used for high scores)
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [app.viewController presentModalViewController:leaderBoardController animated:YES];
    } else {
        [[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
    }
}

-(void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *) viewController {
    //Get app delegate (used for high scores)
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app.viewController dismissModalViewControllerAnimated: YES];
    [viewController release];
    [[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
}

#pragma mark -
#pragma mark Toggle Music

//Turn music on/off
-(void)musicTogglePressed {
	if ([[GameManager sharedGameManager] isMusicON]) {
		CCLOG(@"OptionsLayer-> Turning Game Music OFF");
		[[GameManager sharedGameManager] setIsMusicON:NO];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"ismusicon"];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
	} else {
		CCLOG(@"OptionsLayer-> Turning Game Music ON");
		[[GameManager sharedGameManager] setIsMusicON:YES];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"ismusicon"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:BACKGROUND_TRACK];
	}
}

#pragma mark -
#pragma mark Init

-(id)init {
	self = [super init];
	if (self != nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize; 
		
		CCSprite *background = [CCSprite spriteWithFile:@"ocean_no_block.png"];
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
		
        CCLabelTTF *highScoresButtonLabel = [CCLabelTTF labelWithString:@"High Scores" fontName:@"Marker Felt" fontSize:24.0];
		CCMenuItemLabel	*highScoresButton = [CCMenuItemLabel itemWithLabel:highScoresButtonLabel target:self selector:@selector(showHighScores)];
		
		CCLabelTTF *musicOnLabelText = [CCLabelTTF labelWithString:@"Music is ON" fontName:@"Marker Felt" fontSize:24.0];
		CCLabelTTF *musicOffLabelText = [CCLabelTTF labelWithString:@"Music is OFF" fontName:@"Marker Felt" fontSize:24.0];
    
		
		CCMenuItemLabel *musicOnLabel = [CCMenuItemLabel itemWithLabel:musicOnLabelText target:self selector:nil];
		CCMenuItemLabel *musicOffLabel = [CCMenuItemLabel itemWithLabel:musicOffLabelText target:self selector:nil];

										 
		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(musicTogglePressed) 
																   items:musicOnLabel,musicOffLabel,nil];
				
		CCLabelTTF *creditsButtonLabel = [CCLabelTTF labelWithString:@"Credits" fontName:@"Marker Felt" fontSize:24.0];
		CCMenuItemLabel	*creditsButton = [CCMenuItemLabel itemWithLabel:creditsButtonLabel target:self selector:@selector(showCredits)];
		
		
		//Set up the back button
        CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
        CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(returnToMainMenu)];
        [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
        
        backButtonMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backButtonMenu setPosition:ccp(0,0)];
        [self addChild:backButtonMenu z:kZeroZValue tag:kButtonTagValue];
		
        if ([[GCHelper sharedInstance] userAuthenticated]) {
            CCLabelTTF *gameCenterButtonLabel = [CCLabelTTF labelWithString:@"Game Center" fontName:@"Marker Felt" fontSize:24.0];
            CCMenuItemLabel	*gameCenterButton = [CCMenuItemLabel itemWithLabel:gameCenterButtonLabel target:self selector:@selector(showGameCenter)];
            optionsMenu = [CCMenu menuWithItems:highScoresButton, musicToggle,
                                   creditsButton,gameCenterButton, nil];
        } else {
            optionsMenu = [CCMenu menuWithItems:highScoresButton, musicToggle,
                                   creditsButton, nil];
        }
            
            
        
		[optionsMenu alignItemsVerticallyWithPadding:40.0f];
		[optionsMenu setPosition:ccp(screenSize.width * 0.75f, screenSize.height/2)];
		[self addChild:optionsMenu];
        
        if ([[GameManager sharedGameManager] isMusicON] == NO) {
            [musicToggle setSelectedIndex:1]; // Music is OFF
        }
        
	}
	return self;
}
@end
