//
//  Fish.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"

@interface Fish : GameCharacter {
    //TODO: Insert fish animations here (smiling, gettingEaten, etc.) pg 84
    CCAnimation *fishBlinkingAnim;
    CCAnimation *becomeScaredAnim;
    GameCharacter *penguinCharacter;
}

@property (nonatomic, retain) CCAnimation *fishBlinkingAnim;
@property (nonatomic, retain) CCAnimation *becomeScaredAnim;

@end
