//
//  Level17Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level17Scene.h"
#import "UILayer.h"
#import "Level17ActionLayer.h"

@implementation Level17Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level17ActionLayer *actionLayer = [[[Level17ActionLayer alloc]initWithLevel17UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel17];
    }
    
    return self;
}

@end
