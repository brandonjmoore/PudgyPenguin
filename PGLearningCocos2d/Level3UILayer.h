//
//  Level3UILayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"

@interface Level3UILayer : CCLayer {
    CCLabelTTF *label;
    CCLabelTTF *timeLabel;
}

-(BOOL)displayText:(CCSprite *)sprite andOnCompleteCallTarget:(id)target selector:(SEL)selector;
-(void) displaySecs:(double)secs;

@end
