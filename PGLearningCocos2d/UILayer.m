//
//  UILayer.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/22/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "UILayer.h"

@implementation UILayer

- (id)init {
    
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        label = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:48.0];
        label.position = ccp(winSize.width/2, winSize.height/2);
        label.visible = NO;
        [self addChild:label];
        
        float fontSize = 28.0;
        timeLabel = [CCLabelTTF labelWithString:@"" fontName:@"marker felt" fontSize:fontSize];
        timeLabel.anchorPoint = ccp(0.5f, 0);
        timeLabel.position = ccp(winSize.width *0.5f, winSize.height *0.93f);
        timeLabel.color = ccGRAY;
        [self addChild:timeLabel];
        
        fishLabel = [CCLabelTTF labelWithString:@"" fontName:@"marker felt" fontSize:24.0f];
        fishLabel.anchorPoint = ccp(1, 0.5f);
        fishLabel.position = ccp(winSize.width *0.80f, winSize.height *0.97);
        [self addChild:fishLabel z:8];
        
        CCSprite *fishIdle = [CCSprite spriteWithFile:@"FishIdle.png"];
        fishIdle.position = ccp(fishLabel.position.x + 7, fishLabel.position.y);
        [self addChild:fishIdle];
        
    }
    
    return self;
}

-(BOOL)displayText:(CCSprite *)sprite andOnCompleteCallTarget:(id)target selector:(SEL)selector {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    
    [sprite stopAllActions];
    [sprite setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.75f)];
    
    if (sprite.tag == kBuzzerBeaterSpriteTag) {
        [sprite setScale:10];
        //CCScaleTo *scaleUp = [CCScaleTo actionWithDuration:0.0 scale:10];
        CCScaleTo *scaleBack = [CCScaleTo actionWithDuration:0.5 scale:1.0];
        CCCallFuncN *onComplete = [CCCallFuncN actionWithTarget:target selector:selector];
        //CCSequence *sequence = [CCSequence actions:scaleUp, scaleBack, onComplete, nil];
        CCSequence *sequence = [CCSequence actions:scaleBack, onComplete, nil];
        [self addChild:sprite z:10];
        [sprite runAction:sequence];
        
    } else {
    
        CCScaleTo *scaleUp = [CCScaleTo actionWithDuration:0.5 scale:1.2];
        CCScaleTo *scaleBack = [CCScaleTo actionWithDuration:0.5 scale:1.0];
        CCCallFuncN *onComplete = [CCCallFuncN actionWithTarget:target selector:selector];
        CCSequence *sequence = [CCSequence actions:scaleUp, scaleBack, onComplete, nil];
        [self addChild:sprite z:10];
        [sprite runAction:sequence];
        
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
