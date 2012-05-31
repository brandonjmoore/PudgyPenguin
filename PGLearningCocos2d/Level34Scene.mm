//
//  Level34Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level34Scene.h"
#import "UILayer.h"
#import "Level34ActionLayer.h"

@implementation Level34Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level34ActionLayer *actionLayer = [[[Level34ActionLayer alloc]initWithLevel34UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel34];
    }
    
    return self;
}

@end
