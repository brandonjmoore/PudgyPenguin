//
//  Level30Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level30Scene.h"
#import "UILayer.h"
#import "Level30ActionLayer.h"

@implementation Level30Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level30ActionLayer *actionLayer = [[[Level30ActionLayer alloc]initWithLevel30UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel30];
    }
    
    return self;
}

@end
