//
//  Level12Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level12Scene.h"
#import "Level12UILayer.h"
#import "Level12ActionLayer.h"

@implementation Level12Scene

- (id)init {
    if ((self = [super init])) {
        Level12UILayer *uiLayer = [Level12UILayer node];
        [self addChild:uiLayer z:1];
        Level12ActionLayer *actionLayer = [[[Level12ActionLayer alloc]initWithLevel12UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
