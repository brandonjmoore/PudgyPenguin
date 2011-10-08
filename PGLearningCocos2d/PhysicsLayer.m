//
//  PhysicsLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/8/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "PhysicsLayer.h"

@implementation PhysicsLayer

+ (id)scene {
    CCScene *scene = [CCScene node];
    PhysicsLayer *layer = [self node];
    [scene addChild:layer];
    return scene;
}

- (id)init
{
    if ((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"I love Hungry Penguin!" fontName:@"Helvetica" fontSize:24.0];
        label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:label];
    }
    
    return self;
}

@end
