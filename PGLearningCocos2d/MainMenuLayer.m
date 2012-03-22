//
//  MainMenuLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "MainMenuLayer.h"

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
    else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
        CCLOG(@"Placeholder for next chapters");
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
    if (menuGrid != nil) {
        [menuGrid removeFromParentAndCleanup:YES];
    }
    if (backButtonMenu != nil) {
        [backButtonMenu removeFromParentAndCleanup:YES];
    }
    
    [self removeChild:background cleanup:YES];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        background = [CCSprite spriteWithFile:@"ocean_no_block_iPad.png"];
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
    
    
    CCMenuItemSprite *playGameButton = [CCMenuItemSprite itemFromNormalSprite:startButtonNormal selectedSprite:startButtonSelected disabledSprite:nil target:self selector:@selector(displaySceneSelection)];
    CCMenuItemSprite *moreInfoButton = [CCMenuItemSprite itemFromNormalSprite:moreButtonNormal selectedSprite:moreButtonSelected disabledSprite:nil target:self selector:@selector(displayMoreInfo)];
    
    mainMenu = [CCMenu menuWithItems:playGameButton, nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [mainMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height/2)];
    
    moreInfoMenu = [CCMenu menuWithItems:moreInfoButton, nil];
    [moreInfoMenu setPosition:ccp(screenSize.width * 0.94f, screenSize.height * 0.05f)];

    [self addChild:mainMenu z:kTwoZValue tag:kButtonTagValue];
    [self addChild:moreInfoMenu z:kTwoZValue tag:kButtonTagValue];
                                      
}

//Display levels
-(void)displaySceneSelection {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (mainMenu != nil) {
        [mainMenu removeFromParentAndCleanup:YES];
    }
    
    if (moreInfoMenu != nil) {
        [moreInfoMenu removeFromParentAndCleanup:YES];
    }
    
    [self removeChild:background cleanup:YES];
    
    background = [CCSprite spriteWithFile:@"ocean_no_block.png"];
    [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild:background];
    

    NSMutableArray *menuItemArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 16; i++) {
        CCSprite *levelButtonNormal = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"lvl_%i.png", i]];
        CCSprite *levelButtonSelected = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"lvl_%i_over.png", i]];
 
        
        CCSprite *disabledSprite1 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        
        CCMenuItemSprite *playLevelButton = [CCMenuItemSprite itemFromNormalSprite:levelButtonNormal selectedSprite:nil disabledSprite:disabledSprite1 target:self selector:@selector(playScene:)];
        [playLevelButton setTag:i];
        
        if (i == 1) {
            playLevelButton.isEnabled = YES;
        } else {
            
        playLevelButton.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"level%iunlocked", i]];
            
        }
        
        [menuItemArray addObject:playLevelButton];
        
    }
        
    menuGrid = [SlidingMenuGrid
                                 menuWithArray:menuItemArray
                                 cols:3
                                 rows:3
                                 position:CGPointMake(80.f, 400.f)
                                 padding:CGPointMake(75.f, 75.f)
                                 verticalPaging:false];
    
    [self addChild:menuGrid z:kTwoZValue];
    
    
    
//    sceneSelectMenu1 = [CCMenu menuWithItems:[menuItemArray objectAtIndex:0], [menuItemArray objectAtIndex:1], [menuItemArray objectAtIndex:2], [menuItemArray objectAtIndex:3], nil];
//    sceneSelectMenu2 = [CCMenu menuWithItems:[menuItemArray objectAtIndex:4], [menuItemArray objectAtIndex:5], [menuItemArray objectAtIndex:6], [menuItemArray objectAtIndex:7], nil];
//    sceneSelectMenu3 = [CCMenu menuWithItems:[menuItemArray objectAtIndex:8], [menuItemArray objectAtIndex:9], [menuItemArray objectAtIndex:10], [menuItemArray objectAtIndex:11], nil];
//    sceneSelectMenu4 = [CCMenu menuWithItems:[menuItemArray objectAtIndex:12], [menuItemArray objectAtIndex:13], [menuItemArray objectAtIndex:14], [menuItemArray objectAtIndex:15], nil];
//
//    
//    [sceneSelectMenu1 alignItemsInColumns:[NSNumber numberWithUnsignedInt:2],[NSNumber numberWithUnsignedInt:2], nil];
//    
//    
//    //[sceneSelectMenu1 alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
//    [sceneSelectMenu2 alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
//    [sceneSelectMenu3 alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
//    [sceneSelectMenu4 alignItemsHorizontallyWithPadding:screenSize.width * 0.059f];
//    
//    [sceneSelectMenu1 setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.8f)];
//    [sceneSelectMenu2 setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.65f)];
//    [sceneSelectMenu3 setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.5f)];
//    [sceneSelectMenu4 setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.35f)];
//
//    [self addChild:sceneSelectMenu1 z:kTwoZValue tag:kButtonTagValue];
////    [self addChild:sceneSelectMenu2 z:kTwoZValue tag:kButtonTagValue];
////    [self addChild:sceneSelectMenu3 z:kTwoZValue tag:kButtonTagValue];
////    [self addChild:sceneSelectMenu4 z:kTwoZValue tag:kButtonTagValue];

    //Set up the back button
    CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
    CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(displayMainMenu)];
    [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
    
    backButtonMenu = [CCMenu menuWithItems:backButton, nil];
    
    [backButtonMenu setPosition:ccp(0,0)];
    [self addChild:backButtonMenu z:1 tag:kTwoZValue];
    
    [menuItemArray release];
    
}

-(void)displayMoreInfo {
    CCLOG(@"Show the more info screen");
    [[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
}

#pragma mark -
#pragma mark Audio

-(void)loadAudio {
    soundEngine = [SimpleAudioEngine sharedEngine];
    if ((([[NSUserDefaults standardUserDefaults] boolForKey:@"ismusicon"]) == 1) && (![soundEngine isBackgroundMusicPlaying])) {
        
        [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
        
        [[CDAudioManager sharedManager] setResignBehavior:kAMRBStopPlay autoHandle:YES];
        
        [soundEngine preloadBackgroundMusic:BACKGROUND_TRACK];
        CCLOG(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
        CCLOG(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"ismusicon"]);
        
    
        [soundEngine playBackgroundMusic:BACKGROUND_TRACK];
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
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
        mainMenuSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];//Analyzer shows error here, but we have confirmed that mainMenuSpriteBatchNode is used
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            background = [CCSprite spriteWithFile:@"ocean_no_block_iPad.png"];
        }else {
            background = [CCSprite spriteWithFile:@"MainMenuBG.png"];
        }
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        //Add the buttons to the screen
        [self displayMainMenu];
        snowParticleSystem = [CCParticleSnow node];
        [self addChild:snowParticleSystem z:kOneZValue];
    }    
    return self;
}

@end
