//
//  MainMenuLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameManager.h"
#import "SimpleAudioEngine.h"

@interface MainMenuLayer : CCLayer {
    CCMenu *mainMenu;
    CCMenu *sceneSelectMenu1;
    CCMenu *sceneSelectMenu2;
    CCMenu *sceneSelectMenu3;
    CCMenu *sceneSelectMenu4;
    CCMenu *backButtonMenu;
    CCMenu *moreInfoMenu;
    CCSprite *background;
    
    //Audio
    SimpleAudioEngine *soundEngine;
}

@end
