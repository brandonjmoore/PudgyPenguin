//
//  Level6Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level6Scene.h"
#import "Level6UILayer.h"
#import "Level6ActionLayer.h"

@implementation Level6Scene

- (id)init {
    if ((self = [super init])) {
        Level6UILayer *uiLayer = [Level6UILayer node];
        [self addChild:uiLayer z:1];
        Level6ActionLayer *actionLayer = [[[Level6ActionLayer alloc]initWithLevel6UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
