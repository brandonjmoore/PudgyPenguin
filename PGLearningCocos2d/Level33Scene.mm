//
//  Level33Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level33Scene.h"
#import "UILayer.h"
#import "Level33ActionLayer.h"

@implementation Level33Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level33ActionLayer *actionLayer = [[[Level33ActionLayer alloc]initWithLevel33UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel33];
    }
    
    return self;
}

@end
