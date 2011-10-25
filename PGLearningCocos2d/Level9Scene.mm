//
//  Level9Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level9Scene.h"
#import "Level9UILayer.h"
#import "Level9ActionLayer.h"

@implementation Level9Scene

- (id)init {
    if ((self = [super init])) {
        Level9UILayer *uiLayer = [Level9UILayer node];
        [self addChild:uiLayer z:1];
        Level9ActionLayer *actionLayer = [[[Level9ActionLayer alloc]initWithLevel9UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
