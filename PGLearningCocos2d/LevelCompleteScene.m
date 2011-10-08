//
//  LevelCompleteScene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "LevelCompleteScene.h"
#import "LevelCompleteLayer.h"

@implementation LevelCompleteScene

- (id)init
{
    self = [super init];
	if (self != nil) {
		LevelCompleteLayer *levelCompleteLayer = [LevelCompleteLayer node];
		[self addChild:levelCompleteLayer];
	}
	return self;
}

@end
