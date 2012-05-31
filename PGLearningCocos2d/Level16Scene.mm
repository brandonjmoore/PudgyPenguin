//
//  Level16Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level16Scene.h"
#import "UILayer.h"
#import "Level16ActionLayer.h"

@implementation Level16Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level16ActionLayer *actionLayer = [[[Level16ActionLayer alloc]initWithLevel16UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel16];
    }
    
    return self;
}

@end
