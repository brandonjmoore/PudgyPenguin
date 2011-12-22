//
//  Level11Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level11Scene.h"
#import "UILayer.h"
#import "Level11ActionLayer.h"

@implementation Level11Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level11ActionLayer *actionLayer = [[[Level11ActionLayer alloc]initWithLevel11UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
