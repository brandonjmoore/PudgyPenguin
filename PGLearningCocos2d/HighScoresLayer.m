//
//  HighScoresLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "HighScoresLayer.h"


@implementation HighScoresLayer

-(void)returnToOptionMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMoreInfoScene];
}

#pragma mark -
#pragma mark Clear Scores Methods

-(void)doNoClearScores {
    [[GameManager sharedGameManager] runSceneWithID:kHighScoresScene];
}

-(void)doYesClearScores {
    
    //Get app delegate (used for high scores)
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [app clearAllHighScores];
    
    [[GameManager sharedGameManager] runSceneWithID:kHighScoresScene];
}

-(void)clearAllScores {
    backButtonMenu.isTouchEnabled = NO;
    clearAllScoresMenu.isTouchEnabled = NO;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLayerColor *clearScoresLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 200)];
    
    
    [self addChild:clearScoresLayer z:9];
    
    CCLabelTTF *areYouSureText1 = [CCLabelTTF labelWithString:@"Do you really want to clear" fontName:@"Marker Felt" fontSize:26.0];
    CCLabelTTF *areYouSureText2 = [CCLabelTTF labelWithString:@"all local high scores?" fontName:@"Marker Felt" fontSize:26.0];
    areYouSureText1.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.75f);
    areYouSureText2.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.67f);
    
    [self addChild:areYouSureText1 z:10];
    [self addChild:areYouSureText2 z:10];
    
    CCLabelTTF *noButtonLabel = [CCLabelTTF labelWithString:@"No" fontName:@"Marker Felt" fontSize:48.0];
    CCMenuItemLabel *noButton = [CCMenuItemLabel itemWithLabel:noButtonLabel target:self selector:@selector(doNoClearScores)];
    CCLabelTTF *yesButtonLabel = [CCLabelTTF labelWithString:@"Yes" fontName:@"Marker Felt" fontSize:48.0];
    CCMenuItemLabel *yesButton = [CCMenuItemLabel itemWithLabel:yesButtonLabel target:self selector:@selector(doYesClearScores)];
    
    CCMenu *noYesMenu = [CCMenu menuWithItems:noButton, yesButton, nil];
    [noYesMenu alignItemsVerticallyWithPadding:2.0f];
    noYesMenu.position = ccp(screenSize.width * 0.5f, screenSize.height * 0.45f);
    
    [self addChild:noYesMenu z:10];
    
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
        
        //Get app delegate (used for high scores)
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        //Get High Scores and store in string
        NSString *highScoreTextLevel1 = [[NSString alloc] initWithFormat:@"Level 1: %d", [app getHighScoreForLevel:kLevel1]];
		NSString *highScoreTextLevel2 = [[NSString alloc] initWithFormat:@"Level 2: %d", [app getHighScoreForLevel:kLevel2]];
        NSString *highScoreTextLevel3 = [[NSString alloc] initWithFormat:@"Level 3: %d", [app getHighScoreForLevel:kLevel3]];
        NSString *highScoreTextLevel4 = [[NSString alloc] initWithFormat:@"Level 4: %d", [app getHighScoreForLevel:kLevel4]];
        NSString *highScoreTextLevel5 = [[NSString alloc] initWithFormat:@"Level 5: %d", [app getHighScoreForLevel:kLevel5]];
        NSString *highScoreTextLevel6 = [[NSString alloc] initWithFormat:@"Level 6: %d", [app getHighScoreForLevel:kLevel6]];
        NSString *highScoreTextLevel7 = [[NSString alloc] initWithFormat:@"Level 7: %d", [app getHighScoreForLevel:kLevel7]];
        NSString *highScoreTextLevel8 = [[NSString alloc] initWithFormat:@"Level 8: %d", [app getHighScoreForLevel:kLevel8]];
        NSString *highScoreTextLevel9 = [[NSString alloc] initWithFormat:@"Level 9: %d", [app getHighScoreForLevel:kLevel9]];
        NSString *highScoreTextLevel10 = [[NSString alloc] initWithFormat:@"Level 10: %d", [app getHighScoreForLevel:kLevel10]];
        NSString *highScoreTextLevel11 = [[NSString alloc] initWithFormat:@"Level 11: %d", [app getHighScoreForLevel:kLevel11]];
        NSString *highScoreTextLevel12 = [[NSString alloc] initWithFormat:@"Level 12: %d", [app getHighScoreForLevel:kLevel12]];
        NSString *highScoreTextLevel13 = [[NSString alloc] initWithFormat:@"Level 13: %d", [app getHighScoreForLevel:kLevel13]];
        NSString *highScoreTextLevel14 = [[NSString alloc] initWithFormat:@"Level 14: %d", [app getHighScoreForLevel:kLevel14]];
        NSString *highScoreTextLevel15 = [[NSString alloc] initWithFormat:@"Level 15: %d", [app getHighScoreForLevel:kLevel15]];
        NSString *highScoreTextLevel16 = [[NSString alloc] initWithFormat:@"Level 16: %d", [app getHighScoreForLevel:kLevel16]];
        NSString *totalHighScoreText = [[NSString alloc] initWithFormat:@"Grand Total: %d", [app getTotalHighScore]];
        
		
		CCLabelTTF *textLevel1 = [CCLabelTTF labelWithString:highScoreTextLevel1 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel2 = [CCLabelTTF labelWithString:highScoreTextLevel2 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel3 = [CCLabelTTF labelWithString:highScoreTextLevel3 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel4 = [CCLabelTTF labelWithString:highScoreTextLevel4 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel5 = [CCLabelTTF labelWithString:highScoreTextLevel5 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel6 = [CCLabelTTF labelWithString:highScoreTextLevel6 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel7 = [CCLabelTTF labelWithString:highScoreTextLevel7 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel8 = [CCLabelTTF labelWithString:highScoreTextLevel8 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel9 = [CCLabelTTF labelWithString:highScoreTextLevel9 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel10 = [CCLabelTTF labelWithString:highScoreTextLevel10 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel11 = [CCLabelTTF labelWithString:highScoreTextLevel11 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel12 = [CCLabelTTF labelWithString:highScoreTextLevel12 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel13 = [CCLabelTTF labelWithString:highScoreTextLevel13 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel14 = [CCLabelTTF labelWithString:highScoreTextLevel14 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel15 = [CCLabelTTF labelWithString:highScoreTextLevel15 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textLevel16 = [CCLabelTTF labelWithString:highScoreTextLevel16 fontName:@"Marker Felt" fontSize:20.0];
        CCLabelTTF *textTotal = [CCLabelTTF labelWithString:totalHighScoreText fontName:@"Marker Felt" fontSize:28.0];

        
        textLevel1.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.95f);
        textLevel2.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.9f);
        textLevel3.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.85f);		
        textLevel4.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.8f);		
        textLevel5.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.75f);		
        textLevel6.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.7f);		
        textLevel7.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.65f);		
        textLevel8.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.6f);		
        textLevel9.position = ccp(screenSize.width * 0.77f, screenSize.height * 0.55f);		
        textLevel10.position = ccp(screenSize.width * 0.75f, screenSize.height * 0.5f);		
        textLevel11.position = ccp(screenSize.width * 0.75f, screenSize.height * 0.45f);		
        textLevel12.position = ccp(screenSize.width * 0.75f, screenSize.height * 0.4f);
        textLevel13.position = ccp(screenSize.width * 0.75f, screenSize.height * 0.35f);
        textLevel14.position = ccp(screenSize.width * 0.75f, screenSize.height * 0.3f);
        textLevel15.position = ccp(screenSize.width * 0.75f, screenSize.height * 0.25f);
        textLevel16.position = ccp(screenSize.width * 0.75f, screenSize.height * 0.2f);
        textTotal.position = ccp(screenSize.width * 0.65f, screenSize.height * 0.05f);
		
		//Set up the back button
        CCSprite *backButtonNormal = [CCSprite spriteWithSpriteFrameName:@"BackButtonNormal.png"];
        CCSprite *backButtonSelected = [CCSprite spriteWithSpriteFrameName:@"BackButtonSelected.png"];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:backButtonNormal selectedSprite:backButtonSelected disabledSprite:nil target:self selector:@selector(returnToOptionMenu)];
        [backButton setPosition:ccp(screenSize.width * 0.13f, screenSize.height * 0.95f)];
        
        backButtonMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backButtonMenu setPosition:ccp(0,0)];
        [self addChild:backButtonMenu z:1 tag:kButtonTagValue];
                                   
		
		[self addChild:textLevel1];
        [self addChild:textLevel2];
        [self addChild:textLevel3];
        [self addChild:textLevel4];
        [self addChild:textLevel5];
        [self addChild:textLevel6];
        [self addChild:textLevel7];
        [self addChild:textLevel8];
        [self addChild:textLevel9];
        [self addChild:textLevel10];
        [self addChild:textLevel11];
        [self addChild:textLevel12];
        [self addChild:textLevel13];
        [self addChild:textLevel14];
        [self addChild:textLevel15];
        [self addChild:textLevel16];
        [self addChild:textTotal];
        //[self addChild:clearAllScoresMenu];
        
        [highScoreTextLevel1 release];
        [highScoreTextLevel2 release];
        [highScoreTextLevel3 release];
        [highScoreTextLevel4 release];
        [highScoreTextLevel5 release];
        [highScoreTextLevel6 release];
        [highScoreTextLevel7 release];
        [highScoreTextLevel8 release];
        [highScoreTextLevel9 release];
        [highScoreTextLevel10 release];
        [highScoreTextLevel11 release];
        [highScoreTextLevel12 release];
        [highScoreTextLevel13 release];
        [highScoreTextLevel14 release];
        [highScoreTextLevel15 release];
        [highScoreTextLevel16 release];
		[totalHighScoreText release];
		
	}
	return self;
}

@end
