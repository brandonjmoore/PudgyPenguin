//
//  UILayer.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/22/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"

@interface UILayer : CCLayer {
    CCLabelBMFont *label;
    CCLabelBMFont *timeLabel;
    CCLabelBMFont *fishLabel;
    NSDictionary *starScoresDictionary;
}

-(BOOL)displayText:(CCSprite *)sprite andOnCompleteCallTarget:(id)target selector:(SEL)selector;
-(void) displaySecs:(double)secs;
-(void)displayNumFish:(NSString *)numFish;

@end
