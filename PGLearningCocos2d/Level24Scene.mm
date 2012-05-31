//
//  Level24Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level24Scene.h"
#import "UILayer.h"
#import "Level24ActionLayer.h"

@implementation Level24Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level24ActionLayer *actionLayer = [[[Level24ActionLayer alloc]initWithLevel24UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel24];
    }
    
    return self;
}

@end
