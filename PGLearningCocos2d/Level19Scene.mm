//
//  Level19Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level19Scene.h"
#import "UILayer.h"
#import "Level19ActionLayer.h"

@implementation Level19Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level19ActionLayer *actionLayer = [[[Level19ActionLayer alloc]initWithLevel19UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
