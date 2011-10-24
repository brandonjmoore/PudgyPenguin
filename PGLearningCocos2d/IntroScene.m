//
//  IntroScene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//
#import "IntroScene.h"


@implementation IntroScene
-(id)init {
	self = [super init];
	if (self != nil) {
		IntroLayer *myLayer = [IntroLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
