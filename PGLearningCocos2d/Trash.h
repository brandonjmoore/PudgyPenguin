//
//  Trash.h
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Box2DSprite.h"


@interface Trash : Box2DSprite {
    //b2World *world;
    b2World *world;
    
    CCSpriteFrame *standingFrame;
}

-(id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location;

@end
