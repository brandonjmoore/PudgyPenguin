//
//  Level7Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level7Scene.h"
#import "UILayer.h"
#import "Level7ActionLayer.h"

@implementation Level7Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level7ActionLayer *actionLayer = [[[Level7ActionLayer alloc]initWithLevel7UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel7];
    }
    
    return self;
}

@end
