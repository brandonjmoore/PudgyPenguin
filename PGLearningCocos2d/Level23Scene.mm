//
//  Level23Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level23Scene.h"
#import "UILayer.h"
#import "Level23ActionLayer.h"

@implementation Level23Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level23ActionLayer *actionLayer = [[[Level23ActionLayer alloc]initWithLevel23UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel23];
    }
    
    return self;
}

@end
