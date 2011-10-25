//
//  Level10Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level10Scene.h"
#import "Level10UILayer.h"
#import "Level10ActionLayer.h"

@implementation Level10Scene

- (id)init {
    if ((self = [super init])) {
        Level10UILayer *uiLayer = [Level10UILayer node];
        [self addChild:uiLayer z:1];
        Level10ActionLayer *actionLayer = [[[Level10ActionLayer alloc]initWithLevel10UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end