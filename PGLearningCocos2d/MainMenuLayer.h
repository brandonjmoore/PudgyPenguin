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

@interface MainMenuLayer : CCLayer {
    CCMenu *mainMenu;
    CCMenu *sceneSelectMenu;
    CCMenu *backButtonMenu;
}

@end
