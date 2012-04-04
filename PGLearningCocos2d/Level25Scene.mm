//
//  Level25Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level25Scene.h"
#import "UILayer.h"
#import "Level25ActionLayer.h"

@implementation Level25Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level25ActionLayer *actionLayer = [[[Level25ActionLayer alloc]initWithLevel25UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
