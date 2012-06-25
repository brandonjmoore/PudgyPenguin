//
//  MainMenuLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "LevelSelectLayer.h"
#import "FlurryAnalytics.h"
#import "GameState.h"
#import "GCHelper.h"
#import "GKAchievementHandler.h"

@interface LevelSelectLayer ()
-(void)displaySceneSelection;
@end

@implementation LevelSelectLayer

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
    if ([itemPassedIn tag] == 32) {
        CCLOG(@"Tag 32 found, Scene 32");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel32];
    }
    if ([itemPassedIn tag] == 33) {
        CCLOG(@"Tag 33 found, Scene 33");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel33];
    }
    if ([itemPassedIn tag] == 34) {
        CCLOG(@"Tag 34 found, Scene 34");
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel34];
    }
    else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
    }
}

-(void)displayMainMenu {
    [[GameManager sharedGameManager]runSceneWithID:kMainMenuScene];
}

-(void)buyMoreLevels
{
    [FlurryAnalytics logEvent:@"Tapped buy more levels"];
    if (![[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/pudgy-penguin/id475771110?ls=1&mt=8#"]]) {
        [FlurryAnalytics logEvent:@"Failed to buy more levels"];
    }
}

#pragma mark -
#pragma mark Display Menus

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
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        background = [CCSprite spriteWithFile:@"ocean_no_block_iPad.png"];
    }else {
        background = [CCSprite spriteWithFile:@"ocean_no_block.png"];
    }
    [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild:background];
    

    NSMutableArray *menuItemArray = [[NSMutableArray alloc] init];
    
    didBeatAllLevelsWith3Stars = YES;
    
#if defined (FREEVERSION)
    for (int i = 1; i <= 8; i++) {
#else
    for (int i = 1; i <= 32; i++) {
#endif
//        CCSprite *levelButtonNormal = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"lvl_%i.png", i]];
        CCSprite *levelButtonNormal = [CCSprite spriteWithSpriteFrameName:@"lvl_blank.png"];
        CCLabelBMFont *levelNumber = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%i",i] fntFile:kFONT];
        [levelNumber setPosition:ccp(levelButtonNormal.contentSize.width * .5,levelButtonNormal.contentSize.height * .5)];
        [levelButtonNormal addChild:levelNumber];
        
        //CCSprite *levelButtonSelected = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"lvl_%i_over.png", i]];
 
        
        CCSprite *disabledSprite1 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        
        CCMenuItemSprite *playLevelButton = [CCMenuItemSprite itemFromNormalSprite:levelButtonNormal selectedSprite:nil disabledSprite:disabledSprite1 target:self selector:@selector(playScene:)];
        [playLevelButton setTag:i];
        
        if (i == 1) {
            playLevelButton.isEnabled = YES;
        } else {
            
            playLevelButton.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"level%iunlocked", i]];
            
        }
        
            //This is a more efficient way of tracking what level is unlocked
        
//////////////////////////////TODO: Make sure this is commented out before releasing////////////////////////////////////////////////////////        
//        if (i <= maxLevelUnlocked) {
//            playLevelButton.isEnabled = YES;
//        } else {
//            playLevelButton.isEnabled = NO;
//        }
 //////////////////////////////TODO: Make sure this is commented out before releasing////////////////////////////////////////////////////////
        
        
        NSInteger retrievedScore = [app getHighScoreForLevel:i];
        
        
        
        int lowScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iLow",i]]intValue];
        int medScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iMed",i]]intValue];
        int highScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iHigh",i]]intValue];
        
        if (playLevelButton.isEnabled) {

            if (retrievedScore >= lowScore) {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
                [star setScale:.5];
                [star setPosition:ccp(playLevelButton.contentSize.width * .25,playLevelButton.contentSize.height * .1)];
                [playLevelButton addChild:star];
                
            } else {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
                [star setScale:.5];
                [star setPosition:ccp(playLevelButton.contentSize.width * .25,playLevelButton.contentSize.height * .1)];
                [playLevelButton addChild:star];
                didBeatAllLevelsWith3Stars = NO;
            }
            
            if (retrievedScore >= medScore) {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
                [star setScale:.5];
                [star setPosition:ccp(playLevelButton.contentSize.width * .5,playLevelButton.contentSize.height * .1)];
                [playLevelButton addChild:star];
            } else {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
                [star setScale:.5];
                [star setPosition:ccp(playLevelButton.contentSize.width * .5,playLevelButton.contentSize.height * .1)];
                [playLevelButton addChild:star];
                didBeatAllLevelsWith3Stars = NO;
            }
            
            if (retrievedScore >= highScore) {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
                [star setScale:.5];
                [star setPosition:ccp(playLevelButton.contentSize.width * .75,playLevelButton.contentSize.height * .1)];
                [playLevelButton addChild:star];
            } else {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
                [star setScale:.5];
                [star setPosition:ccp(playLevelButton.contentSize.width * .75,playLevelButton.contentSize.height * .1)];
                [playLevelButton addChild:star];
                didBeatAllLevelsWith3Stars = NO;
            }
        }
        
        
        [menuItemArray addObject:playLevelButton];
        
    }
    
    
    
    
//    for (int i = 17; i <= 31; i++) {
//        
//        NSInteger retrievedScore = [app getHighScoreForLevel:i];
//        int lowScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iLow",i]]intValue];
//        int medScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iMed",i]]intValue];
//        int highScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iHigh",i]]intValue];
//        
//        //CCSprite *levelButtonNormal17 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"lvl_16.png"]];
//        CCSprite *levelButtonNormal17 = [CCSprite spriteWithSpriteFrameName:@"lvl_blank.png"];
//        CCLabelBMFont *levelNumber = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%i",i] fntFile:kFONT];
//        [levelNumber setPosition:ccp(levelButtonNormal17.contentSize.width * .5,levelButtonNormal17.contentSize.height * .5)];
//        [levelButtonNormal17 addChild:levelNumber];
//        //CCSprite *levelButtonSelected17 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"lvl_16_over.png"]];
//        
//        CCSprite *disabledSprite17 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
//        
//        CCMenuItemSprite *playLevelButton17 = [CCMenuItemSprite itemFromNormalSprite:levelButtonNormal17 selectedSprite:nil disabledSprite:disabledSprite17 target:self selector:@selector(playScene:)];
//        [playLevelButton17 setTag:i];
//        
//        playLevelButton17.isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"level%iunlocked", i]];
//        
//        
//        
//        //This is a more efficient way of tracking what level is unlocked
////////////////////////////////TODO: Make sure this is commented out before releasing////////////////////////////////////////////////////////
////        if (i <= maxLevelUnlocked) {
////            playLevelButton17.isEnabled = YES;
////        } else {
////            playLevelButton17.isEnabled = NO;
////        }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        ;
//        
//        if (playLevelButton17.isEnabled) {
//            
//            if (retrievedScore >= lowScore) {
//                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
//                [star setScale:.5];
//                [star setPosition:ccp(playLevelButton17.contentSize.width * .25,playLevelButton17.contentSize.height * .1)];
//                [playLevelButton17 addChild:star];
//                
//            } else {
//                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
//                [star setScale:.5];
//                [star setPosition:ccp(playLevelButton17.contentSize.width * .25,playLevelButton17.contentSize.height * .1)];
//                [playLevelButton17 addChild:star];
//            }
//            
//            if (retrievedScore >= medScore) {
//                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
//                [star setScale:.5];
//                [star setPosition:ccp(playLevelButton17.contentSize.width * .5,playLevelButton17.contentSize.height * .1)];
//                [playLevelButton17 addChild:star];
//            } else {
//                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
//                [star setScale:.5];
//                [star setPosition:ccp(playLevelButton17.contentSize.width * .5,playLevelButton17.contentSize.height * .1)];
//                [playLevelButton17 addChild:star];
//            }
//            
//            if (retrievedScore >= highScore) {
//                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
//                [star setScale:.5];
//                [star setPosition:ccp(playLevelButton17.contentSize.width * .75,playLevelButton17.contentSize.height * .1)];
//                [playLevelButton17 addChild:star];
//            } else {
//                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
//                [star setScale:.5];
//                [star setPosition:ccp(playLevelButton17.contentSize.width * .75,playLevelButton17.contentSize.height * .1)];
//                [playLevelButton17 addChild:star];
//            }
//        }
//        
//        [menuItemArray addObject:playLevelButton17];
//        
//    }
        
    menuGrid = [SlidingMenuGrid
                                 menuWithArray:menuItemArray
                                 cols:4
                                 rows:6
                                 position:ccp(screenSize.width * .2,screenSize.height * .8)
                                 padding:ccp(screenSize.width * .2,screenSize.height * .125)
                                 verticalPaging:false];
    
    CCLOG(@"%i",[GameManager sharedGameManager].lastLevelPlayed);
    
    if ([GameManager sharedGameManager].lastLevelPlayed > 124 ) {
        menuGrid.iCurrentPage = 1;
        [menuGrid jumpToCurrentPage];

    }
        
    [self addChild:menuGrid z:kTwoZValue];
    
    //Set up the back button
    CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
    CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
    
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(displayMainMenu)];
    [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
    
    backButtonMenu = [CCMenu menuWithItems:backButton, nil];
    
    [backButtonMenu setPosition:ccp(0,0)];
    [self addChild:backButtonMenu z:1 tag:kTwoZValue];
    
    [menuItemArray release];
        
        
#if defined (FREEVERSION)
        CCLabelBMFont *moreLevelsButtonLabel = [CCLabelBMFont labelWithString:@"Get More Levels" fntFile:kFONT];
        CCMenuItemLabel	*moreLevelsButton = [CCMenuItemLabel itemWithLabel:moreLevelsButtonLabel target:self selector:@selector(buyMoreLevels)];
        CCMenu *moreLevelsMenu = [CCMenu menuWithItems:moreLevelsButton, nil];
        [moreLevelsMenu setPosition:ccp(screenSize.width * .5, screenSize.height * .15)];
        [self addChild:moreLevelsMenu];
#endif
    

    if (didBeatAllLevelsWith3Stars) {
        if (![GameState sharedInstance].allLevels3Stars) {
            [GameState sharedInstance].allLevels3Stars = true;
            [[GameState sharedInstance] save];
            [[GCHelper sharedInstance] reportAchievement:kAchievement3Stars percentComplete:100.0];
            [[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Achievement Unlocked" andMessage:@"Pudgy Perfectionist"];
        }
    }
    
}

#pragma mark -
#pragma mark Init

- (id)init
{
    self = [super init];
    if (self != nil) {
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSpriteBatchNode *mainMenuSpriteBatchNode;
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"StarScores" ofType:@"plist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            starScoresDictionary = [[NSDictionary alloc]initWithContentsOfFile:path];
        } else {
            //TODO: Do something if file didnt exist
            //starScoresDictionary = [[NSMutableDictionary alloc] init]; 
        }
        
        
        
        
        
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
        [self displaySceneSelection];
//        snowParticleSystem = [CCParticleSnow node];
//        [self addChild:snowParticleSystem z:kOneZValue];
        
        
    }    
    return self;
}

@end
