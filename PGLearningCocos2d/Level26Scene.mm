//
//  Level26Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level26Scene.h"
#import "UILayer.h"
#import "Level26ActionLayer.h"

@implementation Level26Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level26ActionLayer *actionLayer = [[[Level26ActionLayer alloc]initWithLevel26UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel26];
    }
    
    return self;
}

@end
