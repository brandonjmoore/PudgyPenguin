//
//  HighScoresScene.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "HighScoresScene.h"


@implementation HighScoresScene
-(id)init {
	self = [super init];
	if (self != nil) {
		// Background Layer
		myHighScoresLayer = [HighScoresLayer node];
		[self addChild:myHighScoresLayer];
	}
	return self;
}

@end
