//
//  MainMenuScene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "LevelSelectScene.h"

@implementation LevelSelectScene

- (id)init
{
    self = [super init];
    if (self != nil) {
        levelSelectLayer = [LevelSelectLayer node];
        [self addChild:levelSelectLayer];
    }
    
    return self;
}

@end
