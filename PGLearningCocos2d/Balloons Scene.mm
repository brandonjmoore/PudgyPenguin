//
//  Level15Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level15Scene.h"
#import "UILayer.h"
#import "Level15ActionLayer.h"

@implementation Level15Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level15ActionLayer *actionLayer = [[[Level15ActionLayer alloc]initWithLevel15UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
