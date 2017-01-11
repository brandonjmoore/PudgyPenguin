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
#import "Flurry.h"
#import <GameKit/GKScore.h>
#import "CDAudioManager.h"

@implementation MoreInfoLayer

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}

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
//    if ([[GameManager sharedGameManager] isMusicON]) {
//		[Flurry logEvent:@"Turned Music Off"];
//		[[GameManager sharedGameManager] setIsMusicON:NO];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setBool:NO forKey:@"ismusicon"];
//        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
//        [defaults synchronize];
//        
//	} else {
//		[Flurry logEvent:@"Turned Music On"];
//		[[GameManager sharedGameManager] setIsMusicON:YES];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setBool:YES forKey:@"ismusicon"];
//        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:BACKGROUND_TRACK_GAMEPLAY];
//        
//        [defaults synchronize];
//	}
}


-(void)fbLogout {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [[app facebook] logout];
}

-(void)logInToGameCenter {
    
    if (![[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"gamecenter:/"]]) {
        [Flurry logEvent:@"Game Center Link Failed"];
    }
                                                
}

#pragma mark -
#pragma mark Facebook Stuff

-(void)postScoreToFacebook {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//#if defined (FREEVERSION)
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: 
//                                   kFacebookAppID, @"app_id", 
//                                   @"http://itunes.apple.com/us/app/pudgy-penguin/id539265401?ls=1&mt=8#", @"link", 
//                                   @"http://a1.mzstatic.com/us/r1000/116/Purple/cb/e5/08/mzl.jgtgkwba.175x175-75.jpg", @"picture", 
//                                   @"Pudgy Penguin Free!!!", @"name", 
//                                   @"My High Score", @"caption", 
//                                   [NSString stringWithFormat:@"I just threw down %i points in Pudgy Penguin Free! What's your high score?", [app getTotalHighScore]], @"description", 
//                                   @"And boom goes the dynamite!",  @"message", nil];
//    [app doFacebookStuff:params];
//#else
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: 
                                   kFacebookAppID, @"app_id", 
                                   @"http://itunes.apple.com/us/app/pudgy-penguin/id475771110?ls=1&mt=8#", @"link", 
                                   @"http://a1.mzstatic.com/us/r1000/116/Purple/cb/e5/08/mzl.jgtgkwba.175x175-75.jpg", @"picture", 
                                   @"Pudgy Penguin!!!", @"name", 
                                   @"My High Score", @"caption", 
                                   [NSString stringWithFormat:@"I just threw down %i points in Pudgy Penguin! What's your high score?", [app getTotalHighScore]], @"description", 
                                   @"And boom goes the dynamite!",  @"message", nil];
    [app doFacebookStuff:params];
//#endif
    
}

-(void)displayGameCenterStuff {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    if (optionsMenu != nil) {
        [self removeChild:optionsMenu cleanup:YES];
    }
    
    CCLabelBMFont *musicOnLabelText = [CCLabelBMFont labelWithString:@"Music is ON" fntFile:kFONT];
    CCLabelBMFont *musicOffLabelText = [CCLabelBMFont labelWithString:@"Music is OFF" fntFile:kFONT];
    [musicOnLabelText setColor:ccWHITE];
    
    
    CCMenuItemLabel *musicOnLabel = [CCMenuItemLabel itemWithLabel:musicOnLabelText target:self selector:nil];
    CCMenuItemLabel *musicOffLabel = [CCMenuItemLabel itemWithLabel:musicOffLabelText target:self selector:nil];
    
    
    CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
                                                            selector:@selector(musicTogglePressed) 
                                                               items:musicOnLabel,musicOffLabel,nil];
    [musicToggle setColor:ccWHITE];
    
    if ([[GameManager sharedGameManager] isMusicON] == NO) {
        [musicToggle setSelectedIndex:1]; // Music is OFF
    }
    
    if ([[GCHelper sharedInstance] userAuthenticated]) {
        CCLabelBMFont *gameCenterButtonLabel = [CCLabelBMFont labelWithString:@"Leaderboard" fntFile:kFONT];
        CCMenuItemLabel	*gameCenterButton = [CCMenuItemLabel itemWithLabel:gameCenterButtonLabel target:self selector:@selector(showGameCenter)];
        
        CCLabelBMFont *achievementsButtonLabel = [CCLabelBMFont labelWithString:@"Achievements" fntFile:kFONT];
        CCMenuItemLabel	*achievementsButton = [CCMenuItemLabel itemWithLabel:achievementsButtonLabel target:self selector:@selector(showAchievements)];
        
        optionsMenu = [CCMenu menuWithItems: gameCenterButton, achievementsButton, musicToggle, nil];
        
        
    } else if (![[GCHelper sharedInstance] userAuthenticated]) {
        CCLabelBMFont *gameCenterButtonLabel = [CCLabelBMFont labelWithString:@"Sign in to Game Center" fntFile:kFONT];
        CCMenuItemLabel	*gameCenterButton = [CCMenuItemLabel itemWithLabel:gameCenterButtonLabel target:self selector:@selector(logInToGameCenter)];
        optionsMenu = [CCMenu menuWithItems: gameCenterButton, musicToggle, nil];
    } else {
        optionsMenu = [CCMenu menuWithItems: musicToggle, nil];
    }
    
    
    
    [optionsMenu alignItemsVerticallyWithPadding:20.0f];
    [optionsMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height * .14)];
    [self addChild:optionsMenu];
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
//        CCLabelBMFont *highScoresButtonLabel = [CCLabelBMFont labelWithString:@"High Scores" fntFile:kFONT];
//		CCMenuItemLabel	*highScoresButton = [CCMenuItemLabel itemWithLabel:highScoresButtonLabel target:self selector:@selector(showHighScores)];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        NSInteger highScore = [app getTotalHighScore];
        
        if (highScore > 0) {
            CCLabelBMFont *totalHighScoreText = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"Total Score: %d", highScore]  fntFile:kFONT];
            [totalHighScoreText setPosition:ccp(screenSize.width * .5, screenSize.height * .8)];
            [self addChild:totalHighScoreText];
            
            CCSprite *facebookButtonSprite = [CCSprite spriteWithSpriteFrameName:@"post_to_facebook.png"];
            CCMenuItemSprite *facebookButton = [CCMenuItemSprite itemFromNormalSprite:facebookButtonSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(postScoreToFacebook)];
            
            CCMenu *facebookMenu = [CCMenu menuWithItems:facebookButton, nil];
            [facebookMenu setPosition:ccp(screenSize.width * .5, screenSize.height * .7)];
            [self addChild:facebookMenu];
        }
		
		
				
//		CCLabelBMFont *creditsButtonLabel = [CCLabelBMFont labelWithString:@"Credits" fntFile:kFONT];
//		CCMenuItemLabel	*creditsButton = [CCMenuItemLabel itemWithLabel:creditsButtonLabel target:self selector:@selector(showCredits)];
//		
//        CCLabelBMFont *facebookButtonLabel = [CCLabelBMFont labelWithString:@"Logout of Facebook" fntFile:kFONT];
//		CCMenuItemLabel	*facebookButton = [CCMenuItemLabel itemWithLabel:facebookButtonLabel target:self selector:@selector(fbLogout)];
		
        
		//Set up the back button
        CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
        CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(returnToMainMenu)];
        [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
        
        backButtonMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backButtonMenu setPosition:ccp(0,0)];
        [self addChild:backButtonMenu z:kZeroZValue tag:kButtonTagValue];
		
        [self displayGameCenterStuff];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(displayGameCenterStuff) name:kGCAuthenticationChangedNotification object:nil];
        
	}
	return self;
}
@end
