//
//  Level22Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level22Scene.h"
#import "UILayer.h"
#import "Level22ActionLayer.h"

@implementation Level22Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level22ActionLayer *actionLayer = [[[Level22ActionLayer alloc]initWithLevel22UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
