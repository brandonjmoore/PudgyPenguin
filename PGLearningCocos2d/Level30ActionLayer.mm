//
//  Level30ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level30ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"
#import "math.h"

#import "MyColorLayer.h"

@implementation Level30ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            [self createFish2AtLocation:ccp(screenSize.width * .25,screenSize.height * 1.05)];
            //fish.body->ApplyLinearImpulse(b2Vec2(6,1), fish.body->GetWorldCenter());
            //fish.body->SetTransform(fish.body->GetPosition() , CC_DEGREES_TO_RADIANS(0));
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
            [self createTrashAtLocation:ccp(screenSize.width * .25,screenSize.height * 1.05)];
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel30];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level31unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:31]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel31];
}

#pragma mark -
#pragma mark Init and Update Stuffs

-(void)setupBackground {
    CCSprite *backgroundImage;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        backgroundImage = [CCSprite spriteWithFile:@"night_background_ipad.png"];
    }else {
        backgroundImage = [CCSprite spriteWithFile:@"night_background.png"];
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
    if (remainingTime > [app getHighScoreForLevel:kLevel30] && [app getHighScoreForLevel:kLevel30] > 0) {
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
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel30];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel30];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 30 high score: %d", levelHighScore];
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
    [defaults setBool:YES forKey:@"level31unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:31]];
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

-(id)initWithLevel30UILayer:(UILayer *)level30UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        
        
        [FlurryAnalytics logEvent:@"Level 30 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 31;
   
        [self setupBackground];
        uiLayer = level30UILayer;
        
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
        
        [self createPenguin2AtLocation:ccp(winSize.width * .85, winSize.height * .1)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        Box2DSprite * myPlatform;
        Box2DSprite * myPlatform2;
        if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            myPlatform = [self createPlatformAtLocation:ccp(winSize.width * 1,winSize.height * .5) ofType:kExtraExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(270)];
            myPlatform2 = [self createPlatformAtLocation:ccp(winSize.width * 0,winSize.height * .49) ofType:kExtraExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(90)];
        } else {
            myPlatform = [self createPlatformAtLocation:ccp(winSize.width * 1.075,winSize.height * .5) ofType:kExtraExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(270)];
            myPlatform2 = [self createPlatformAtLocation:ccp(winSize.width * -.075,winSize.height * .49) ofType:kExtraExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(90)];
        }
        
        CCDelayTime *rot1 = [CCDelayTime actionWithDuration:3];
        CCRotateTo *rot2 = [CCRotateTo actionWithDuration:2 angle:155];
        CCRotateTo *rot3 = [CCRotateTo actionWithDuration:2 angle:90];
        CCSequence *seq = [CCSequence actions:rot1,rot2,rot3, nil];
        
        [myPlatform runAction:[CCRepeatForever actionWithAction:seq]];
        
        
        
        CCDelayTime *rot4 = [CCDelayTime actionWithDuration:3];
        CCRotateTo *rot5 = [CCRotateTo actionWithDuration:2 angle:205];
        CCRotateTo *rot6 = [CCRotateTo actionWithDuration:2 angle:270];
        CCSequence *seq2 = [CCSequence actions:rot4,rot5,rot6, nil];
        
        [myPlatform2 runAction:[CCRepeatForever actionWithAction:seq2]];
        
        
        Box2DSprite *myBox = [self createBoxAtLocation:ccp(winSize.width * .1,winSize.height * .35) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        Box2DSprite *myBox2 = [self createBoxAtLocation:ccp(winSize.width * .9,winSize.height * .65) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        Box2DSprite *myBox3 = [self createBoxAtLocation:ccp(winSize.width * .5,winSize.height * .5) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        Box2DSprite *myBox4 = [self createBoxAtLocation:ccp(winSize.width * .5,winSize.height * .8) ofType:kBouncyBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        [myBox runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];
        id mov1 = [CCMoveBy actionWithDuration:4 position:ccp(winSize.width * .8,0)];
        id mov2 = [mov1 reverse];
        CCSequence *seq5 = [CCSequence actions:mov1,mov2, nil];
        [myBox runAction:[CCRepeatForever actionWithAction:seq5]];
        
        [myBox2 runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:-360]]];
        id mov3 = [CCMoveBy actionWithDuration:4 position:ccp(winSize.width * -.8,0)];
        id mov4 = [mov3 reverse];
        CCSequence *seq6 = [CCSequence actions:mov3,mov4, nil];
        [myBox2 runAction:[CCRepeatForever actionWithAction:seq6]];
        
        [myBox3 runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:-360]]];
        id mov5 = [CCMoveBy actionWithDuration:2 position:ccp(winSize.width * -.4,0)];
        id mov7 = [CCMoveBy actionWithDuration:4 position:ccp(winSize.width * .8,0)];
        CCSequence *seq3 = [CCSequence actions:mov5,mov7,mov5, nil];
        [myBox3 runAction:[CCRepeatForever actionWithAction:seq3]];
        
        [myBox4 runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:-360]]];
        id mov8 = [CCMoveBy actionWithDuration:2 position:ccp(winSize.width * .4,0)];
        id mov9 = [CCMoveBy actionWithDuration:4 position:ccp(winSize.width * -.8,0)];
        CCSequence *seq4 = [CCSequence actions:mov8,mov9,mov8, nil];
        [myBox4 runAction:[CCRepeatForever actionWithAction:seq4]];
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //create trash every so often
        [self schedule:@selector(addTrash) interval:7];
        
    }
    return self;
}


@end
