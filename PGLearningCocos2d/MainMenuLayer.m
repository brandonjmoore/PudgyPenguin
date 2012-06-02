//
//  MainMenuLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "MainMenuLayer.h"
#import "FlurryAnalytics.h"

@interface MainMenuLayer ()
-(void)displayMainMenu;
-(void)displaySceneSelection;
@end

@implementation MainMenuLayer

-(void)openFacebookPage {
    if (![[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"fb://profile/119643394810914"]]) {
        if (![[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.facebook.com/pudgypenguin"]]) {
            CCLOG(@"Failed to open facebook url");
            [FlurryAnalytics logEvent:@"Facebook like failed"];
        }
    }
    
}

#pragma mark -
#pragma mark Display Menus

-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
//    if (sceneSelectMenu1 != nil) {
//        [sceneSelectMenu1 removeFromParentAndCleanup:YES];
//    }
//    if (sceneSelectMenu2 != nil) {
//        [sceneSelectMenu2 removeFromParentAndCleanup:YES];
//    }
//    if (sceneSelectMenu3 != nil) {
//        [sceneSelectMenu3 removeFromParentAndCleanup:YES];
//    }
//    if (sceneSelectMenu4 != nil) {
//        [sceneSelectMenu4 removeFromParentAndCleanup:YES];
//    }
    
    
    //TODO: Check if this works
//    if ([[GameManager sharedGameManager]returnToLevels]) {
//        [self displaySceneSelection];
//        return;
//    }
    
    if (menuGrid != nil) {
        [menuGrid removeFromParentAndCleanup:YES];
    }
    if (backButtonMenu != nil) {
        [backButtonMenu removeFromParentAndCleanup:YES];
    }
    
    [self removeChild:background cleanup:YES];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        background = [CCSprite spriteWithFile:@"MainMenuBG_iPad.png"];
    }else {
        background = [CCSprite spriteWithFile:@"MainMenuBG.png"];
    }
    [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild:background];
    
    //Main Menu
    CCSprite *startButtonNormal = [CCSprite spriteWithSpriteFrameName:@"PlayGameButtonNormal.png"];
    CCSprite *startButtonSelected = [CCSprite spriteWithSpriteFrameName:@"PlayGameButtonSelected.png"];
    
    CCSprite *moreButtonNormal = [CCSprite spriteWithSpriteFrameName:@"help.png"];
    CCSprite *moreButtonSelected = [CCSprite spriteWithSpriteFrameName:@"help_over.png"];
    
    CCSprite *facebookLikeSprite = [CCSprite spriteWithSpriteFrameName:@"facebook_like.png"];
    
    
    CCMenuItemSprite *playGameButton = [CCMenuItemSprite itemFromNormalSprite:startButtonNormal selectedSprite:startButtonSelected disabledSprite:nil target:self selector:@selector(displaySceneSelection)];
    CCMenuItemSprite *moreInfoButton = [CCMenuItemSprite itemFromNormalSprite:moreButtonNormal selectedSprite:moreButtonSelected disabledSprite:nil target:self selector:@selector(displayMoreInfo)];
    CCMenuItemSprite *facebookLikeButton = [CCMenuItemSprite itemFromNormalSprite:facebookLikeSprite selectedSprite:nil disabledSprite:nil target:self selector:@selector(openFacebookPage)];
    
    mainMenu = [CCMenu menuWithItems:playGameButton, nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [mainMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height * .45)];
    
    CCMenu *facebookMenu = [CCMenu menuWithItems:facebookLikeButton, nil];
    [facebookMenu setPosition:ccp(screenSize.width * 0.5,screenSize.height * 0.25)];
    
    moreInfoMenu = [CCMenu menuWithItems:moreInfoButton, nil];
    [moreInfoMenu setPosition:ccp(screenSize.width * 0.94f, screenSize.height * 0.05f)];
    
    
    [self addChild:mainMenu z:kTwoZValue tag:kButtonTagValue];
    [self addChild:moreInfoMenu z:kTwoZValue tag:kButtonTagValue];
    [self addChild:facebookMenu z:kTwoZValue tag:kButtonTagValue];
                                      
}

//Display levels
-(void)displaySceneSelection {
    
    [[GameManager sharedGameManager]runSceneWithID:kLevelSelectScene];
    
}

-(void)displayMoreInfo {
    [FlurryAnalytics logEvent:@"More Info Button Tapped"];
    [[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
}

#pragma mark -
#pragma mark Audio

-(void)loadAudio {
    soundEngine = [SimpleAudioEngine sharedEngine];
    if ((([[NSUserDefaults standardUserDefaults] boolForKey:@"ismusicon"]) == 1) && (![soundEngine isBackgroundMusicPlaying])) {
        
        [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_HIGH];
        
        [[CDAudioManager sharedManager] setResignBehavior:kAMRBStopPlay autoHandle:YES];
        
        [soundEngine preloadBackgroundMusic:BACKGROUND_TRACK_GAMEPLAY];
//        CCLOG(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
//        CCLOG(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"ismusicon"]);
        
    
        [soundEngine playBackgroundMusic:BACKGROUND_TRACK_GAMEPLAY];
        
        //[soundEngine setBackgroundMusicVolume:.5];
        
//        [soundEngine preloadEffect:@"Level Failed.mp3"];
    }
}

#pragma mark -
#pragma mark Init

- (id)init
{
    self = [super init];
    if (self != nil) {
        
        [self loadAudio];
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSpriteBatchNode *mainMenuSpriteBatchNode;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            background = [CCSprite spriteWithFile:@"ocean_no_block_iPad.png"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas_iPad.plist"];
            mainMenuSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas_iPad.png"];//Analyzer shows error here, but we have confirmed that mainMenuSpriteBatchNode is used
        }else {
            background = [CCSprite spriteWithFile:@"MainMenuBG.png"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
            mainMenuSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];//Analyzer shows error here, but we have confirmed that mainMenuSpriteBatchNode is used
        }
        
        //Get app delegate (used for high scores)
        app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        maxLevelUnlocked = [app getMaxLevelUnlocked];
        
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        //Add the buttons to the screen
        [self displayMainMenu];
//        snowParticleSystem = [CCParticleSnow node];
//        [self addChild:snowParticleSystem z:kOneZValue];
        
        
    }    
    return self;
}

@end
