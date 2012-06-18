//
//  Level27ActionLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level27ActionLayer.h"
#import "Penguin2.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"
#import "math.h"

@implementation Level27ActionLayer

#pragma mark - Add Fish/Trash

-(void)addFish {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //If the penguin is satisfied, dont add any more fish
    if (penguin2 != nil) {
        if (!gameOver) {
            Box2DSprite *fish = [self createFish2AtLocation:ccp(screenSize.width * -.03,screenSize.height * .55)];
            if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                fish.body->ApplyLinearImpulse(b2Vec2(6.2,2), fish.body->GetWorldCenter());
            } else {
                fish.body->ApplyLinearImpulse(b2Vec2(6,1.2), fish.body->GetWorldCenter());
            }
            
            fish.body->SetTransform(fish.body->GetPosition() , CC_DEGREES_TO_RADIANS(0));
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
            Box2DSprite *myTrash = [self createTrashAtLocation:ccp(screenSize.width * -.04,screenSize.height * .55)];
            if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                myTrash.body->ApplyLinearImpulse(b2Vec2(6.2,2), myTrash.body->GetWorldCenter());
            } else {
                myTrash.body->ApplyLinearImpulse(b2Vec2(6,1), myTrash.body->GetWorldCenter());
            }
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
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel27];//Level Specific: Change for new level
}

-(void) doNextLevel {
    self.isTouchEnabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"level28unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:28]];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel28];
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
    if (remainingTime > [app getHighScoreForLevel:kLevel27] && [app getHighScoreForLevel:kLevel27] > 0) {
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
    [app setHighScore:[NSNumber numberWithDouble:remainingTime] forLevel:kLevel27];
    
    NSInteger levelHighScore = [app getHighScoreForLevel:kLevel27];
    NSString *levelScoreString = [NSString stringWithFormat:@"Level 27 high score: %d", levelHighScore];
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
    [defaults setBool:YES forKey:@"level28unlocked"];
    [defaults synchronize];
    if (appDel != nil) {
        [appDel saveMaxLevelUnlocked:[NSNumber numberWithInt:28]];
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

-(id)initWithLevel27UILayer:(UILayer *)level27UILayer {
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [FlurryAnalytics logEvent:@"Level 27 Started"];
        
        lineArray = [[NSMutableArray array] retain];
        lineSpriteArray = [[NSMutableArray array] retain];
        lineArrayMaster = [[NSMutableArray array] retain];
        lineSpriteArrayMaster = [[NSMutableArray array] retain];
        
        startTime = CACurrentMediaTime();
        remainingTime = 31;
   
        [self setupBackground];
        uiLayer = level27UILayer;
        
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
        
        [self createPenguin2AtLocation:ccp(winSize.width * .5, winSize.height * .4)];
        penguin2 = (Penguin2*)[sceneSpriteBatchNode getChildByTag:kPenguinSpriteTagValue];
        
        [self createPlatformAtLocation:ccp(winSize.width * .495,winSize.height *.32) ofType:kLargePlatform withRotation:CC_DEGREES_TO_RADIANS(-90)];
        
        
        [self createPlatformAtLocation:ccp(winSize.width * .3,winSize.height * .5) ofType:kExtraExtraLargePlatform withRotation:CC_DEGREES_TO_RADIANS(90)];
        
        if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [self createPlatformAtLocation:ccp(winSize.width * .775,winSize.height *.405) ofType:kMediumPlatform withRotation:CC_DEGREES_TO_RADIANS(0)];
            [self createBoxAtLocation:ccp(winSize.width * .775,winSize.height * .5)  ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
            [self createBoxAtLocation:ccp(winSize.width * .775,winSize.height * .3) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        } else {
            [self createPlatformAtLocation:ccp(winSize.width * .815,winSize.height *.405) ofType:kMediumPlatform withRotation:CC_DEGREES_TO_RADIANS(0)];
            [self createBoxAtLocation:ccp(winSize.width * .815,winSize.height * .5)  ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
            [self createBoxAtLocation:ccp(winSize.width * .815,winSize.height * .3) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)]; 
            
        }
    
        
        Box2DSprite *balloon = [self createBoxAtLocation:ccp(winSize.width * .2,winSize.height * .3) ofType:kBalloonBox withRotation:CC_DEGREES_TO_RADIANS(0)];
        
        id mov = [CCMoveBy actionWithDuration:6 position:ccp(0,winSize.height * .2)];
        id movRev = [mov reverse];
        
        CCSequence *seq = [CCSequence actions:mov,movRev, nil];
        
        [balloon runAction:[CCRepeatForever actionWithAction:seq]];
        
        
        
               
        
        
        //Create fish every so many seconds.
        [self schedule:@selector(addFish) interval:kTimeBetweenFishCreation];
        
        //create trash every so often
        //[self schedule:@selector(addTrash) interval:7];
        
    }
    return self;
}


@end
