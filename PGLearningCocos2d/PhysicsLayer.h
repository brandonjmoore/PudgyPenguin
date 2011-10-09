//
//  PhysicsLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/8/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Constants.h"

@interface PhysicsLayer : CCLayer {
    b2World * world;
    GLESDebugDraw * debugDraw;
}

+ (id)scene;

@end
