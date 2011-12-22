//
//  UILayer.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/22/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"

@interface UILayer : CCLayer {
    CCLabelTTF *label;
    CCLabelTTF *timeLabel;
    CCLabelTTF *fishLabel;
}

-(BOOL)displayText:(CCSprite *)sprite andOnCompleteCallTarget:(id)target selector:(SEL)selector;
-(void) displaySecs:(double)secs;
-(void)displayNumFish:(NSString *)numFish;

@end