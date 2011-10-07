//
//  GameplayLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "Penguin.h"

@interface GameplayLayer : CCLayer <GameplayLayerDelegate>{
    CCSprite *penguinSprite;
    CCSpriteBatchNode *sceneSpriteBatchNode;
}

@end
