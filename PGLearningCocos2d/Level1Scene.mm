//
//  level1Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "level1Scene.h"
#import "level1UILayer.h"
#import "level1ActionLayer.h"

@implementation level1Scene

- (id)init {
    if ((self = [super init])) {
        level1UILayer *uiLayer = [level1UILayer node];
        [self addChild:uiLayer z:1];
        level1ActionLayer *actionLayer = [[[level1ActionLayer alloc]initWithlevel1UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
