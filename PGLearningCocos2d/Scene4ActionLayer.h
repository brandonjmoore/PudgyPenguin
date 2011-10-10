//
//  Scene4ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Constants.h"

@class Scene4UILayer;
@class Penguin2;

@interface Scene4ActionLayer : CCLayer {
    b2World *world;
    GLESDebugDraw *debugDraw;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    b2Body *groundBody;
    Penguin2 *penguin2;
    Scene4UILayer *uiLayer;
}

-(id)initWithScene4UILayer:(Scene4UILayer *)scene4UILayer;

@end
