//
//  MoreInfoLayer.h
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
#import <GameKit/GameKit.h>
#import "FBConnect.h"

@interface MoreInfoLayer : CCLayer <GKLeaderboardViewControllerDelegate, FBSessionDelegate, FBDialogDelegate> {
    CCMenu *backButtonMenu;
    CCMenu *optionsMenu;
    Facebook *facebook;
}

@property (nonatomic, retain) Facebook *facebook;

@end
