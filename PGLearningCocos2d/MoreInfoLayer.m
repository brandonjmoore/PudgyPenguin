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
#import "FlurryAnalytics.h"

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

-(void)showAchievements {
    GKAchievementViewController *achievementController = [[GKAchievementViewController alloc] init];
    
    if (achievementController != NULL) {
        achievementController.achievementDelegate = self;
        //Get app delegate (used for high scores)
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [app.viewController presentModalViewController:achievementController animated:YES];
    } else {
        [[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
    }
}

-(void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
    //Get app delegate (used for high scores)
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app.viewController dismissModalViewControllerAnimated: YES];
    [viewController release];
    [[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
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
		[FlurryAnalytics logEvent:@"Turned Music Off"];
		[[GameManager sharedGameManager] setIsMusicON:NO];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"ismusicon"];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [defaults synchronize];
        
	} else {
		[FlurryAnalytics logEvent:@"Turned Music On"];
		[[GameManager sharedGameManager] setIsMusicON:YES];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"ismusicon"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:BACKGROUND_TRACK_GAMEPLAY];
        [defaults synchronize];
	}
}


-(void)fbLogout {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [[app facebook] logout];
}


#pragma mark -
#pragma mark Init

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
		
//        CCLabelBMFont *highScoresButtonLabel = [CCLabelBMFont labelWithString:@"High Scores" fntFile:kFONT];
        CCLabelBMFont *highScoresButtonLabel = [CCLabelBMFont labelWithString:@"High Scores" fntFile:kFONT];
		CCMenuItemLabel	*highScoresButton = [CCMenuItemLabel itemWithLabel:highScoresButtonLabel target:self selector:@selector(showHighScores)];
        
		
		
		CCLabelBMFont *musicOnLabelText = [CCLabelBMFont labelWithString:@"Music is ON" fntFile:kFONT];
		CCLabelBMFont *musicOffLabelText = [CCLabelBMFont labelWithString:@"Music is OFF" fntFile:kFONT];
        [musicOnLabelText setColor:ccWHITE];
    
		
		CCMenuItemLabel *musicOnLabel = [CCMenuItemLabel itemWithLabel:musicOnLabelText target:self selector:nil];
		CCMenuItemLabel *musicOffLabel = [CCMenuItemLabel itemWithLabel:musicOffLabelText target:self selector:nil];

										 
		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(musicTogglePressed) 
																   items:musicOnLabel,musicOffLabel,nil];
        [musicToggle setColor:ccWHITE];
				
		CCLabelBMFont *creditsButtonLabel = [CCLabelBMFont labelWithString:@"Credits" fntFile:kFONT];
		CCMenuItemLabel	*creditsButton = [CCMenuItemLabel itemWithLabel:creditsButtonLabel target:self selector:@selector(showCredits)];
		
        CCLabelBMFont *facebookButtonLabel = [CCLabelBMFont labelWithString:@"Logout of Facebook" fntFile:kFONT];
		CCMenuItemLabel	*facebookButton = [CCMenuItemLabel itemWithLabel:facebookButtonLabel target:self selector:@selector(fbLogout)];
		
        
		//Set up the back button
        CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
        CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(returnToMainMenu)];
        [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
        
        backButtonMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backButtonMenu setPosition:ccp(0,0)];
        [self addChild:backButtonMenu z:kZeroZValue tag:kButtonTagValue];
		
        if ([[GCHelper sharedInstance] userAuthenticated]) {
            CCLabelBMFont *gameCenterButtonLabel = [CCLabelBMFont labelWithString:@"Game Center" fntFile:kFONT];
            CCMenuItemLabel	*gameCenterButton = [CCMenuItemLabel itemWithLabel:gameCenterButtonLabel target:self selector:@selector(showGameCenter)];
            
            CCLabelBMFont *achievementsButtonLabel = [CCLabelBMFont labelWithString:@"Achievements" fntFile:kFONT];
            CCMenuItemLabel	*achievementsButton = [CCMenuItemLabel itemWithLabel:achievementsButtonLabel target:self selector:@selector(showAchievements)];
            
            optionsMenu = [CCMenu menuWithItems: achievementsButton,highScoresButton, musicToggle,
                                   creditsButton,gameCenterButton, facebookButton, nil];
        } else {
            optionsMenu = [CCMenu menuWithItems:highScoresButton, musicToggle,
                                   creditsButton, facebookButton, nil];
        }
            
            
        
		[optionsMenu alignItemsVerticallyWithPadding:20.0f];
		[optionsMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height/2)];
		[self addChild:optionsMenu];
        
        if ([[GameManager sharedGameManager] isMusicON] == NO) {
            [musicToggle setSelectedIndex:1]; // Music is OFF
        }
        
	}
	return self;
}
@end
