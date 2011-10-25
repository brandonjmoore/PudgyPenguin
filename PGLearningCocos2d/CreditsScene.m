//
//  CreditsScene.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "CreditsScene.h"


@implementation CreditsScene
-(id)init {
	self = [super init];
	if (self != nil) {
		// Background Layer
		myCreditsLayer = [CreditsLayer node];
		[self addChild:myCreditsLayer];
	}
	return self;
}

@end
