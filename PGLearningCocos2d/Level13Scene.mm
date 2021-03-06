//
//  Level13Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level13Scene.h"
#import "UILayer.h"
#import "Level13ActionLayer.h"

@implementation Level13Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level13ActionLayer *actionLayer = [[[Level13ActionLayer alloc]initWithLevel13UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel13];
    }
    
    return self;
}

@end
