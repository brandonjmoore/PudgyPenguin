//
//  Level33ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level33ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"
#import "math.h"

#import "MyColorLayer.h"

@implementation Level33ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * .85,screenSize.height * 1.05)];
            
            //fish.body->SetTransform(fish.body->GetPosition() , CC_DEGREES_TO_RADIANS(90));
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
            [self createTrashAtLocation:ccp(screenSize.width * .85,screenSize.height * 1.05)];
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel33];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level34unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:34]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel34];
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
    if (remainingTime > [app getHighScoreForLevel:kLevel33] && [app getHighScoreForLevel:kLevel33] > 0) {
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
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel33];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel33];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 33 high score: %d", levelHighScore];
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
}

-(void) gameOverPass: (id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level34unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:34]];
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
        [self createBoxAtLocation:ccp(winSize.width, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(45)];
    } else {
        [self createBoxAtLocation:ccp(0, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        [self createBoxAtLocation:ccp(winSize.width, winSize.height * yPosition) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
    }
    
    
    
}
-(void)addBalloons {
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    Box2DSprite *myBalloon = [self createBoxAtLocation:ccp(winSize.width * val,winSize.height * -.05) ofType:kBalloonBox withRotation:0];
    
    [myBalloon runAction:[CCMoveTo actionWithDuration:15 position:ccp(winSize.width * val,winSize.height * 1.05)]];
    
    CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.2 angle:-4.0];
    CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.2 angle:0.0];
    CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.2 angle:4.0];
    CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
    [myBalloon runAction:[CCRepeatForever actionWithAction:rotSeq]];
}

-(id)initWithLevel33UILayer:(UILayer *)level33UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        
        
        [FlurryAnalytics logEvent:@"Level 33 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 46;
   
        [self setupBackground];
        uiLayer = level33UILayer;
        
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
        
//        [self createPenguin2AtLocation:ccp(winSize.width * .1, winSize.height * .125)];
        [self createPenguin2AtLocation:ccp(winSize.width * 0, winSize.height * .6)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        [penguin2 setNumFishRequired:5];
        [penguin2 setRotation:90];
        
//        [self createBoxAtLocation:ccp(winSize.width * .1, winSize.height * .01) ofType:kNormalBox withRotation:CC_DEGREES_TO_RADIANS(0)];
            
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        

        
        [self createBoxAtLocation:ccp(winSize.width * 0.65f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];        
        [self createBoxAtLocation:ccp(winSize.width * 0.5f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        
        [self createBoxAtLocation:ccp(winSize.width * 0.35f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        [self createBoxAtLocation:ccp(winSize.width * 0.2f, winSize.height *0.05f) ofType:kBouncyBox withRotation:DEG_TO_RAD(0)];
        
        [self createPlatformAtLocation:ccp(winSize.width * .575, winSize.height * 0.1f) ofType:kMediumPlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * .575, winSize.height * 0.65f) ofType:kExtraExtraLargePlatform withRotation:0.0f];
        
        [self createPlatformAtLocation:ccp(winSize.width * 0.275f, winSize.height * 0.1f) ofType:kLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.275f, winSize.height * 0.7f) ofType:kExtraLargePlatform withRotation:0.0f];
        
        [self createPlatformAtLocation:ccp(winSize.width * 0.425f, winSize.height * 0.2f) ofType:kLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.425f, winSize.height * 0.8f) ofType:kExtraLargePlatform withRotation:0.0f];
        
        [self createPlatformAtLocation:ccp(winSize.width * .125, winSize.height * 0.25f) ofType:kExtraLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * .125, winSize.height * 0.85f) ofType:kLargePlatform withRotation:0.0f];
        
        [self createPlatformAtLocation:ccp(winSize.width * 0.725f, winSize.height * 0.3f) ofType:kExtraExtraLargePlatform withRotation:0.0f];
        [self createPlatformAtLocation:ccp(winSize.width * 0.725f, winSize.height * 0.95f) ofType:kLargePlatform withRotation:0.0f];

        [self createPlatformAtLocation:ccp(winSize.width * 0.4f, winSize.height * 1.5f) ofType:kExtraExtraLargePlatform withRotation:1.0f];
        
        
        //create trash every so often
//        [self schedule:@selector(addTrash) interval:7];
        
    }
    return self;
}


@end
