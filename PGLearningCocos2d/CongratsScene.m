//
//  CongratsScene.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "CongratsScene.h"

@implementation CongratsScene
-(id)init {
	self = [super init];
	if (self != nil) {
		CongratsLayer *myLayer = [CongratsLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
