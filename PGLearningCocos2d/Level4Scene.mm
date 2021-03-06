//
//  Level4Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level4Scene.h"
#import "UILayer.h"
#import "Level4ActionLayer.h"

@implementation Level4Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level4ActionLayer *actionLayer = [[[Level4ActionLayer alloc]initWithLevel4UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel4];
    }
    
    return self;
}

@end
