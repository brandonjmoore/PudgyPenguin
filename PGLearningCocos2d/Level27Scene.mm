//
//  Level27Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level27Scene.h"
#import "UILayer.h"
#import "Level27ActionLayer.h"

@implementation Level27Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level27ActionLayer *actionLayer = [[[Level27ActionLayer alloc]initWithLevel27UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel27];
    }
    
    return self;
}

@end
