//
//  Level32Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level32Scene.h"
#import "UILayer.h"
#import "Level32ActionLayer.h"

@implementation Level32Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level32ActionLayer *actionLayer = [[[Level32ActionLayer alloc]initWithLevel32UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
        [self setTag:kLevel32];
    }
    
    return self;
}

@end
