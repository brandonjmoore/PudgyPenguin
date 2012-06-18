//
//  UILayer.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/22/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "UILayer.h"
#import "GKAchievementHandler.h"
#import "GKAchievementNotification.h"
#import "AppDelegate.h"
#import "ActionLayer.h"

@implementation UILayer

@synthesize fishLabel,timeLabel;

- (id)init {
    
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
//        CCSprite *topBar = [CCSprite spriteWithFile:@"top_bar.png"];
//        [topBar setPosition:ccp(winSize.width * .5,winSize.height - [topBar boundingBox].size.height/2)];
//        [self addChild:topBar z:-100];
        
        
        
        label = [CCLabelBMFont labelWithString:@"" fntFile:kFONT];
        label.position = ccp(winSize.width/2, winSize.height/2);
        label.visible = NO;
        [self addChild:label];
        
        timeLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT];
        timeLabel.anchorPoint = ccp(0.5f, 0);
        timeLabel.position = ccp(winSize.width *0.5f, winSize.height *0.93f);
        timeLabel.color = ccWHITE;
        [self addChild:timeLabel];
        
        fishLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT];
        fishLabel.anchorPoint = ccp(1, 0.5f);
        fishLabel.position = ccp(winSize.width *0.85f, winSize.height *0.96);
        [self addChild:fishLabel z:8];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"StarScores" ofType:@"plist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            starScoresDictionary = [[NSDictionary alloc]initWithContentsOfFile:path];
        }
        
        
        
//        CCSprite *fishIdle = [CCSprite spriteWithFile:@"FishIdle.png"];
//        fishIdle.position = ccp(fishLabel.position.x + 7, fishLabel.position.y);
//        [self addChild:fishIdle];
        
//        CCParticleFireworks *fireworks = [CCParticleFireworks node];
//        
//        ccColor4B myColor = ccc4(135,206,250, 255);
//        //[fireworks setStartColor:ccc4FFromccc4B(myColor)];
//        [fireworks setStartColor:ccc4FFromccc3B(ccWHITE)];
//        [fireworks setEndColor:ccc4FFromccc4B(myColor)];
//        [fireworks setPosition:ccp(winSize.width * .5,winSize.height * -.1)];
//        [fireworks setAngle:90];
//        [fireworks setSpeed:250];
//        [fireworks autoRemoveOnFinish];
//        
//        [self addChild:fireworks z:-100];
        
    }
    
    return self;
}

-(BOOL)displayText:(CCSprite *)sprite andOnCompleteCallTarget:(id)target selector:(SEL)selector {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    
    [sprite stopAllActions];
    [sprite setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.85f)];
    
    if (sprite.tag == kBuzzerBeaterSpriteTag) {
        
//        CCParticleFireworks *fireworks = [CCParticleFireworks node];
//        
//        ccColor4B myColor = ccc4(135,206,250, 255);
//        //[fireworks setStartColor:ccc4FFromccc4B(myColor)];
//        [fireworks setStartColor:ccc4FFromccc3B(ccWHITE)];
//        [fireworks setEndColor:ccc4FFromccc4B(myColor)];
//        [fireworks setPosition:ccp(winSize.width * 1.01,winSize.height * .5)];
//        [fireworks setAngle:112.5];
//        [fireworks setSpeed:200];
//        [fireworks autoRemoveOnFinish];
//        
//        [self addChild:fireworks z:-100];
//        
//        CCParticleFireworks *fireworks2 = [CCParticleFireworks node];
//        
//        //[fireworks setStartColor:ccc4FFromccc4B(myColor)];
//        [fireworks2 setStartColor:ccc4FFromccc3B(ccWHITE)];
//        [fireworks2 setEndColor:ccc4FFromccc4B(myColor)];
//        [fireworks2 setPosition:ccp(winSize.width * -.01,winSize.height * .5)];
//        [fireworks2 setAngle:67.5];
//        [fireworks2 setSpeed:200];
//        [fireworks2 autoRemoveOnFinish];
//        
//        [self addChild:fireworks2 z:-100];
        
        CCParticleSystem *partSys = [CCParticleFlower node];
        [partSys setPosition: sprite.position];
        [partSys autoRemoveOnFinish];
        [self addChild:partSys];
        
        [sprite setScale:10];
        CCScaleTo *scaleBack = [CCScaleTo actionWithDuration:0.5 scale:1.0];
        CCCallFuncN *onComplete = [CCCallFuncN actionWithTarget:target selector:selector];
        CCSequence *sequence = [CCSequence actions:scaleBack, onComplete, nil];
        [self addChild:sprite z:10];
        [sprite runAction:sequence];
        
    } else if (sprite.tag == kAchievementUnlockedBuzzerBeater){
        
        
        // notify the user
        // grab an achievement description from where ever you saved them
        
        [[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Achievement Unlocked" andMessage:@"Buzzer Beater Master!!!"];
        
//        CCParticleFireworks *fireworks = [CCParticleFireworks node];
//        
//        ccColor4B myColor = ccc4(135,206,250, 255);
//        //[fireworks setStartColor:ccc4FFromccc4B(myColor)];
//        [fireworks setStartColor:ccc4FFromccc3B(ccWHITE)];
//        [fireworks setEndColor:ccc4FFromccc4B(myColor)];
//        [fireworks setPosition:ccp(winSize.width * 1.01,winSize.height * .5)];
//        [fireworks setAngle:112.5];
//        [fireworks setSpeed:200];
//        [fireworks autoRemoveOnFinish];
//        
//        [self addChild:fireworks z:-100];
//        
//        CCParticleFireworks *fireworks2 = [CCParticleFireworks node];
//        
//        //[fireworks setStartColor:ccc4FFromccc4B(myColor)];
//        [fireworks2 setStartColor:ccc4FFromccc3B(ccWHITE)];
//        [fireworks2 setEndColor:ccc4FFromccc4B(myColor)];
//        [fireworks2 setPosition:ccp(winSize.width * -.01,winSize.height * .5)];
//        [fireworks2 setAngle:67.5];
//        [fireworks2 setSpeed:200];
//        [fireworks2 autoRemoveOnFinish];
//        
//        [self addChild:fireworks2 z:-100];
        
        CCParticleSystem *partSys = [CCParticleFlower node];
        [partSys setPosition: sprite.position];
        [partSys autoRemoveOnFinish];
        [self addChild:partSys];
        
        [sprite setScale:10];
        CCScaleTo *scaleBack = [CCScaleTo actionWithDuration:0.5 scale:1.0];
        CCCallFuncN *onComplete = [CCCallFuncN actionWithTarget:target selector:selector];
        CCSequence *sequence = [CCSequence actions:scaleBack, onComplete, nil];
        [self addChild:sprite z:10];
        [sprite runAction:sequence];
        
        
    } else {
    
        CCScaleTo *scaleUp = [CCScaleTo actionWithDuration:0.25 scale:1.4];
        CCScaleTo *scaleBack = [CCScaleTo actionWithDuration:0.25 scale:1.0];
        CCCallFuncN *onComplete = [CCCallFuncN actionWithTarget:target selector:selector];
        CCSequence *sequence = [CCSequence actions: onComplete,scaleUp, scaleBack, nil];
        [self addChild:sprite z:10];
        [sprite runAction:sequence];
        
    }
    
    CCScene * current = [[CCDirector sharedDirector] runningScene];
    
    NSInteger levelTag = current.tag;
    if (current.tag > 0) {
        ActionLayer * layer = (ActionLayer *)[current getChildByTag:kActionLayer];
        
        //NSInteger retrievedScore = [app getHighScoreForLevel:i];
        NSInteger retrievedScore = layer.remainingTime;
        int lowScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iLow",levelTag]]intValue];
        int medScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iMed",levelTag]]intValue];
        int highScore = [[starScoresDictionary objectForKey:[NSString stringWithFormat:@"Level%iHigh",levelTag]]intValue];
        
        if (layer.remainingTime > 0) {
        
            if (retrievedScore >= lowScore) {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
                [star setPosition:ccp(winSize.width * .4,winSize.height * .15)];
                [self addChild:star];
                
            } else {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
                [star setPosition:ccp(winSize.width * .4,winSize.height * .15)];
                [self addChild:star];
            }
            
            if (retrievedScore >= medScore) {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
                [star setPosition:ccp(winSize.width * .5,winSize.height * .15)];
                [self addChild:star];
            } else {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
                [star setPosition:ccp(winSize.width * .5,winSize.height * .15)];
                [self addChild:star];
            }
            
            if (retrievedScore >= highScore) {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Gold.png"];
                [star setPosition:ccp(winSize.width * .6,winSize.height * .15)];
                [self addChild:star];
            } else {
                CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"Star_Silver.png"];
                [star setPosition:ccp(winSize.width * .6,winSize.height * .15)];
                [self addChild:star];
            }
        }
    }
    
    return TRUE;
    
}

-(void) displaySecs:(double)secs {
    secs = MAX(0, secs);
    
    double intPart = 0;
    modf(secs, &intPart);
    int isecs = (int)intPart;
    //int min = isecs / 60;
    int sec = isecs % 60;
    //int hund = (int) (fractPart * 100);
    [timeLabel setString:[NSString stringWithFormat:@"%d", sec]];
    
}

-(void)displayNumFish:(NSString *)numFishText {
    [fishLabel stopAllActions];
    
    [fishLabel setString:[NSString stringWithFormat:@"%@", numFishText]];
    
}

@end
