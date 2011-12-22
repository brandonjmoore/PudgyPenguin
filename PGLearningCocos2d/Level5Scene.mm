//
//  Level5Scene.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Level5Scene.h"
#import "UILayer.h"
#import "Level5ActionLayer.h"

@implementation Level5Scene

- (id)init {
    if ((self = [super init])) {
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:1];
        Level5ActionLayer *actionLayer = [[[Level5ActionLayer alloc]initWithLevel5UILayer:uiLayer]autorelease];
        [self addChild:actionLayer z:0];
    }
    
    return self;
}

@end
