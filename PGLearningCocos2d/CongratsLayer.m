//
//  CongratsLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "CongratsLayer.h"
#import "FlurryAnalytics.h"
#import "AppDelegate.h"

@implementation CongratsLayer

#pragma mark -
#pragma mark Switch Menus

-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

#pragma mark -
#pragma mark Facebook Stuff

-(void)postScoreToFacebook {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: 
                                   kFacebookAppID, @"app_id", 
                                   @"http://itunes.apple.com/us/app/pudgy-penguin/id475771110?ls=1&mt=8#", @"link", 
                                   @"http://a1.mzstatic.com/us/r1000/116/Purple/cb/e5/08/mzl.jgtgkwba.175x175-75.jpg", @"picture", 
                                   @"Pudgy Penguin!!!", @"name", 
                                   @"I beat Pudgy Penguin", @"caption", 
                                   [NSString stringWithFormat:@"I just beat Pudgy Penguin with %i points! What's your high score?", [app getTotalHighScore]], @"description", 
                                   @"And boom goes the dynamite!",  @"message", nil];
    [app doFacebookStuff:params];
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
            CCLabelBMFont *congratulationstext = [CCLabelBMFont labelWithString:@"Congratulations!" fntFile:kFONT];
            [congratulationstext setPosition:ccp(screenSize.width * .5, screenSize.height * .7)];
            [self addChild:congratulationstext];
            
            
            CCLabelBMFont *totalHighScoreText = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"Your Total Score is %d", highScore] fntFile:kFONT];
            [totalHighScoreText setPosition:ccp(screenSize.width * .5, screenSize.height * .6)];
            [self addChild:totalHighScoreText];
            
            CCSprite *facebookButtonSprite = [CCSprite spriteWithSpriteFrameName:@"post_to_facebook.png"];
            CCMenuItemSprite *facebookButton = [CCMenuItemSprite itemFromNormalSprite:facebookButtonSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(postScoreToFacebook)];
            
            CCMenu *facebookMenu = [CCMenu menuWithItems:facebookButton, nil];
            [facebookMenu setPosition:ccp(screenSize.width * .5, screenSize.height * .5)];
            [self addChild:facebookMenu];
        }
		
        
		//Set up the back button
        CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
        CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(returnToMainMenu)];
        [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
        
        backButtonMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backButtonMenu setPosition:ccp(0,0)];
        [self addChild:backButtonMenu z:kZeroZValue tag:kButtonTagValue];
        
        //Add snow
        CCParticleSystem *snowParticleSystem = [CCParticleSnow node];
        [snowParticleSystem autoRemoveOnFinish];
        [self addChild:snowParticleSystem];
        
	}
	return self;
}
@end
