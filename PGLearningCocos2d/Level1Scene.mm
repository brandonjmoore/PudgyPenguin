//
//  Level1Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level1Scene.h"
#import "Level1ActionLayer.h"
#import "UILayer.h"

@implementation Level1Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level1ActionLayer *actionLayer = [[[Level1ActionLayer alloc]initWithLevel1UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel1];
    }
    
    return self;
}

@end
