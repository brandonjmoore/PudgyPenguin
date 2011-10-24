//
//  Level2UILayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level2UILayer.h"

@implementation Level2UILayer

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
        
    }
    
    return self;
}

-(BOOL)displayText:(CCSprite *)sprite andOnCompleteCallTarget:(id)target selector:(SEL)selector {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    
    [sprite stopAllActions];
    [sprite setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.75f)];
    
    CCScaleTo *scaleUp = [CCScaleTo actionWithDuration:0.5 scale:1.2];
    CCScaleTo *scaleBack = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    //CCDelayTime *delay = [CCDelayTime actionWithDuration:2.0];
    //CCFadeOut *fade = [CCFadeOut actionWithDuration:0.5];
    //CCHide *hide = [CCHide action];
    CCCallFuncN *onComplete = [CCCallFuncN actionWithTarget:target selector:selector];
    CCSequence *sequence = [CCSequence actions:scaleUp, scaleBack, onComplete, nil];
    [self addChild:sprite z:10];
    [sprite runAction:sequence];
    return TRUE;
    
}

-(void) displaySecs:(double)secs {
    secs = MAX(0, secs);
    
    double intPart = 0;
    double fractPart = modf(secs, &intPart);
    int isecs = (int)intPart;
    //int min = isecs / 60;
    int sec = isecs % 60;
    //int hund = (int) (fractPart * 100);
    [timeLabel setString:[NSString stringWithFormat:@"%d", sec]];
    
}

@end
