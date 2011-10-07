//
//  MainMenuScene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "MainMenuScene.h"

@implementation MainMenuScene

- (id)init
{
    self = [super init];
    if (self != nil) {
        mainMenuLayer = [MainMenuLayer node];
        [self addChild:mainMenuLayer];
    }
    
    return self;
}

@end
