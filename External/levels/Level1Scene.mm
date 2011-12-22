//
//  Level1Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level1Scene.h"
#import "Level1UILayer.h"
#import "Level1ActionLayer.h"

@implementation Level1Scene

- (id)init {
    if ((self = [super init])) {
        Level1UILayer *uiLayer = [Level1UILayer node];
        [self addChild:uiLayer z:1];
        Level1ActionLayer *actionLayer = [[[Level1ActionLayer alloc]initWithLevel1UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
