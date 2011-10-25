//
//  MoreInfoScene.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "MoreInfoScene.h"

@implementation MoreInfoScene
-(id)init {
	self = [super init];
	if (self != nil) {
		MoreInfoLayer *myLayer = [MoreInfoLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
