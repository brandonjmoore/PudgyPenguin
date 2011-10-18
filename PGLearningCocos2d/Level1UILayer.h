//
//  Level1UILayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"

@interface Level1UILayer : CCLayer {
    CCLabelTTF *label;
}

-(BOOL)displayText:(NSString *)text andOnCompleteCallTarget:(id)target selector:(SEL)selector;

@end
