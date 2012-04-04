//
//  Level21Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level21Scene.h"
#import "UILayer.h"
#import "Level21ActionLayer.h"

@implementation Level21Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level21ActionLayer *actionLayer = [[[Level21ActionLayer alloc]initWithLevel21UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
