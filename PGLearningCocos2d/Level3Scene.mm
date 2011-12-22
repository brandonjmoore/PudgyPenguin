//
//  Level3Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level3Scene.h"
#import "Level3ActionLayer.h"
#import "UILayer.h"

@implementation Level3Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level3ActionLayer *actionLayer = [[[Level3ActionLayer alloc]initWithLevel3UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
