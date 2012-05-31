//
//  Level8Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level8Scene.h"
#import "UILayer.h"
#import "Level8ActionLayer.h"

@implementation Level8Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level8ActionLayer *actionLayer = [[[Level8ActionLayer alloc]initWithLevel8UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel8];
    }
    
    return self;
}

@end
