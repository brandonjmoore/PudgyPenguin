//
//  Fish2.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Box2DSprite.h"

@interface Fish2 : Box2DSprite {
    b2World *world;
    BOOL isPenguinWithinBounginBox; 
}

-(id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location;

@end
