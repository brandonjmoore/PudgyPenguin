//
//  Level26ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level26ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "Flurry.h"
#import "math.h"

@implementation Level26ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            Box2DSprite *fish = [self createFish2AtLocation:ccp(screenSize.width * .5,screenSize.height * -.03)];
            
            if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                fish.body->ApplyLinearImpulse(b2Vec2(0,5.7), fish.body->GetWorldCenter());
                fish.body->ApplyAngularImpulse(-.025);
            } else {
                fish.body->ApplyLinearImpulse(b2Vec2(0,4.5), fish.body->GetWorldCenter());
                fish.body->ApplyAngularImpulse(-.025);
            }
            
            
            fish.body->SetTransform(fish.body->GetPosition() , CC_DEGREES_TO_RADIANS(90));
            numFishCreated++;
        }else {
            //If the Penguin is satisfied, dont create fish
            [self unschedule:@selector(addFish)];
        }
    }    
}

-(void)addTrash {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createTrashAtLocation:ccp(screenSize.width * -.03,screenSize.height * .425)];
            
        }else {
            //If the Penguin is satisfied, dont create fish
            [self unschedule:@selector(addTrash)];
        }
    }    
}

#pragma mark -
#pragma mark Pause Stuff

-(void) doResetLevel {
    self.isTouchEnabled = YES;
    
    [[CCDirector sharedDirector] resume];
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel26];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level27unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:27]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel27];
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCSprite *backgroundImage;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        backgroundImage = [CCSprite spriteWithFile:@"ocean_no_block_iPad.png"];
    }else {
        backgroundImage = [CCSprite spriteWithFile:@"ocean_no_block.png"];
    }
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
    
    [self addChild:backgroundImage z:-10 tag:0];
}

-(void)doHighScoreStuff {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //Get app delegate (used for high scores)
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    //Show level High Score (new high scores only)
    if (remainingTime > [app getHighScoreForLevel:kLevel26] && [app getHighScoreForLevel:kLevel26] > 0) {
        NSString *levelHighScoreText = [NSString stringWithFormat:@"New High Score!"];
        CCLabelBMFont *levelHighScoreLabel = [CCLabelBMFont labelWithString:levelHighScoreText fntFile:kFONT];
        levelHighScoreLabel.position = ccp(winSize.width * 0.5f, winSize.height * 0.25f);
        [self addChild:levelHighScoreLabel z:10];
        
        CCParticleExplosion *explosion = [CCParticleExplosion node];
        [explosion autoRemoveOnFinish];
        explosion.position = levelHighScoreLabel.position;
        [explosion setSpeed:50];
        [self addChild:explosion z:10];
    }
    
    
    //Set the High Score (if new value is greater than old value)
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel26];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel26];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 26 high score: %d", levelHighScore];
    CCLabelBMFont *levelScoreText = [CCLabelBMFont labelWithString:levelScoreString fntFile:kFONT];
    [levelScoreText setScale:.67];
    levelScoreText.position = ccp(winSize.width * 0.48f, winSize.height * 0.1f);
    [self addChild:levelScoreText z:10];
    
    
    //Show total high score
    NSInteger totalHighScore = [app getTotalHighScore];
    
    NSString *highScoreString = [NSString stringWithFormat:@"Total high score: %d", totalHighScore];
    CCLabelBMFont *highScoreText = [CCLabelBMFont labelWithString:highScoreString fntFile:kFONT];
    [highScoreText setScale:.67];
    highScoreText.position = ccp(winSize.width * 0.48f, winSize.height * 0.05f);
    [self addChild:highScoreText z:10];
    
    if ([[GameManager sharedGameManager]lastLevelPlayed] > 100 ) {
        CCLabelBMFont *currentLevelText = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"level %i",[[GameManager sharedGameManager]lastLevelPlayed]-100] fntFile:kFONT];
        [currentLevelText setPosition:ccp(winSize.width * 0.5, winSize.height * 0.7)];
        [self addChild:currentLevelText z:10];
    }
}

-(void) gameOverPass: (id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level27unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:27]];
    }
    
    clearButton.isEnabled = NO;
    pauseButton.isEnabled = NO;
    self.isTouchEnabled = NO;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayerColor *levelCompleteLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 100)];
    [self addChild:levelCompleteLayer z:9];

    CCMenu *nextLevelMenu = [self createMenu];
    [nextLevelMenu alignItemsVerticallyWithPadding:winSize.height * 0.04f];
    [nextLevelMenu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
    [self addChild:nextLevelMenu z:10];
    
    [self doHighScoreStuff];
    
}

-(void)createPlatformAtWidth:(float)yPosition {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int myInt = (int)(yPosition*100);
    
    if (myInt % 2 == 0) {
        [self createBoxAtLocation:ccp(0, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(45)];
        [self createBoxAtLocation:ccp(winSize.width, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
    } else {
        [self createBoxAtLocation:ccp(0, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(45)];
    }
    
    
    
}

-(id)initWithLevel26UILayer:(UILayer *)level26UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [Flurry logEvent:@"Level 26 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 60;
   
        [self setupBackground];
        uiLayer = level26UILayer;
        
        [self setupWorld];
        //[self setupDebugDraw];
        [self scheduleUpdate];
        [self schedule:@selector(updateTime) interval:1.0];
        [self createPauseButton];
        [self createClearButton];
        self.isTouchEnabled = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas_iPad.png"];
        }else {
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        }
        [self addChild:sceneSpriteBatchNode z:-1];
        
        [self createPenguin2AtLocation:ccp(winSize.width * .5, winSize.height)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        

        [penguin2 setRotation:180];
        
        
        for (float i = .1; i < .9; i=i+.15) {
            [self createPlatformAtWidth:i];
        }
        
        //[self createPlatformAtLocation:ccp(winSize.width * .05,winSize.height * .5) ofType:kExtraExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        //[self createBoxAtLocation:ccp(winSize.width * 0.3,winSize.height * .05) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation + 1.5];
        
        //create trash every so often
        //[self schedule:@selector(addTrash) interval:6];
        
    }
    return self;
}


@end
