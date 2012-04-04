//
//  Level18Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level18Scene.h"
#import "UILayer.h"
#import "Level18ActionLayer.h"

@implementation Level18Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level18ActionLayer *actionLayer = [[[Level18ActionLayer alloc]initWithLevel18UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
