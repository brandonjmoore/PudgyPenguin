//
//  MovingBox.h
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/18/11.
//  Copyright 2011 Vaux. All rights reserved.
//

#import "Box2DSprite.h"


@interface MovingBox : Box2DSprite {
    b2World *world;
    
    CCSpriteFrame *standingFrame;
}

-(b2Body*)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location ofType:(MovingBoxType)movingBoxType withRotation:(float)rotation;

@end
