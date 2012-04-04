//
//  Level20Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level20Scene.h"
#import "UILayer.h"
#import "Level20ActionLayer.h"

@implementation Level20Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level20ActionLayer *actionLayer = [[[Level20ActionLayer alloc]initWithLevel20UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
