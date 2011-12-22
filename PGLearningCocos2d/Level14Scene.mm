//
//  Level14Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level14Scene.h"
#import "UILayer.h"
#import "Level14ActionLayer.h"

@implementation Level14Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level14ActionLayer *actionLayer = [[[Level14ActionLayer alloc]initWithLevel14UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
