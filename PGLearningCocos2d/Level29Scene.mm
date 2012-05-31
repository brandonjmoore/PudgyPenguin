//
//  Level29Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level29Scene.h"
#import "UILayer.h"
#import "Level29ActionLayer.h"

@implementation Level29Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level29ActionLayer *actionLayer = [[[Level29ActionLayer alloc]initWithLevel29UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel29];
    }
    
    return self;
}

@end
