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

#pragma mark -
#pragma mark Level Selected

-(void)playScene:(CCMenuItemFont*)itemPassedIn {
    if ([itemPassedIn tag] == 1) {
        CCLOG(@"Tag 1 found, Scene 1");
        [[GameManager sharedGameManager] runSceneWithID:kIntroScene];
    }
    if ([itemPassedIn tag] == 2) {
        CCLOG(@"Tag 2 found, Scene 2");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel2];
    }
    if ([itemPassedIn tag] == 3) {
        CCLOG(@"Tag 3 found, Scene 3");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel3];
    }
    if ([itemPassedIn tag] == 4) {
        CCLOG(@"Tag 4 found, Scene 4");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel4];
    }
    if ([itemPassedIn tag] == 5) {
        CCLOG(@"Tag 5 found, Scene 5");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel5];
    }
    if ([itemPassedIn tag] == 6) {
        CCLOG(@"Tag 6 found, Scene 6");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel6];
    }
    if ([itemPassedIn tag] == 7) {
        CCLOG(@"Tag 7 found, Scene 7");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel7];
    }
    if ([itemPassedIn tag] == 8) {
        CCLOG(@"Tag 8 found, Scene 8");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel8];
    }
    if ([itemPassedIn tag] == 9) {
        CCLOG(@"Tag 9 found, Scene 9");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel9];
    }
    if ([itemPassedIn tag] == 10) {
        CCLOG(@"Tag 10 found, Scene 10");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel10];
    }
    if ([itemPassedIn tag] == 11) {
        CCLOG(@"Tag 11 found, Scene 11");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel11];
    }
    if ([itemPassedIn tag] == 3) {
        CCLOG(@"Tag 3 found, Scene 3");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel3];
    } 
    if ([itemPassedIn tag] == 12) {
        CCLOG(@"Tag 12 found, Scene 12");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel12];
    }
    if ([itemPassedIn tag] == 13) {
        CCLOG(@"Tag 13 found, Scene 13");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel13];
    }
    if ([itemPassedIn tag] == 14) {
        CCLOG(@"Tag 14 found, Scene 14");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel14];
    }
    if ([itemPassedIn tag] == 15) {
        CCLOG(@"Tag 15 found, Scene 15");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel15];
    }
    if ([itemPassedIn tag] == 16) {
        CCLOG(@"Tag 16 found, Scene 16");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel16];
    }
    if ([itemPassedIn tag] == 17) {
        CCLOG(@"Tag 17 found, Scene 17");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel17];
    }
    if ([itemPassedIn tag] == 18) {
        CCLOG(@"Tag 18 found, Scene 18");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel18];
    }
    if ([itemPassedIn tag] == 19) {
        CCLOG(@"Tag 19 found, Scene 19");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel19];
    }
    if ([itemPassedIn tag] == 20) {
        CCLOG(@"Tag 20 found, Scene 20");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel20];
    }
    if ([itemPassedIn tag] == 21) {
        CCLOG(@"Tag 21 found, Scene 21");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel21];
    }
    if ([itemPassedIn tag] == 22) {
        CCLOG(@"Tag 22 found, Scene 22");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel22];
    }
    if ([itemPassedIn tag] == 23) {
        CCLOG(@"Tag 23 found, Scene 23");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel23];
    }
    if ([itemPassedIn tag] == 24) {
        CCLOG(@"Tag 24 found, Scene 24");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel24];
    }
    if ([itemPassedIn tag] == 25) {
        CCLOG(@"Tag 24 found, Scene 24");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel25];
    }
    if ([itemPassedIn tag] == 26) {
        CCLOG(@"Tag 26 found, Scene 26");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel26];
    }
    if ([itemPassedIn tag] == 27) {
        CCLOG(@"Tag 27 found, Scene 27");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel27];
    }
    if ([itemPassedIn tag] == 28) {
        CCLOG(@"Tag 28 found, Scene 28");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel28];
    }
    if ([itemPassedIn tag] == 29) {
        CCLOG(@"Tag 29 found, Scene 29");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel29];
    }
    if ([itemPassedIn tag] == 30) {
        CCLOG(@"Tag 30 found, Scene 30");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel30];
    }
    if ([itemPassedIn tag] == 31) {
        CCLOG(@"Tag 31 found, Scene 31");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel31];
    }
    else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
    }
}

-(void)openFacebookPage {
    if (![[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"fb://page/119643394810914"]]) {
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
