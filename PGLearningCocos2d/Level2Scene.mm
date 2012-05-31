//
//  Level2Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level2Scene.h"
#import "Level2ActionLayer.h"
#import "UILayer.h"

@implementation Level2Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level2ActionLayer *actionLayer = [[[Level2ActionLayer alloc]initWithLevel2UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel2];
    }
    
    return self;
}

@end
