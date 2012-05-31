//
//  Level28Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level28Scene.h"
#import "UILayer.h"
#import "Level28ActionLayer.h"

@implementation Level28Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level28ActionLayer *actionLayer = [[[Level28ActionLayer alloc]initWithLevel28UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel28];
    }
    
    return self;
}

@end
