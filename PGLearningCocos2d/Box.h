//
//  Box.h
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/18/11.
//  Copyright 2011 Vaux. All rights reserved.
//

#import "Box2DSprite.h"


@interface Box : Box2DSprite {
    b2World *world;
    BOOL readyForWiggle;
    
    CCSpriteFrame *standingFrame;
}

-(id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location ofType:(BoxType)boxType withRotation:(float)rotation;

@end
