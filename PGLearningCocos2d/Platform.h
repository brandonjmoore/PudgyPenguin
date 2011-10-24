//
//  Platform.h
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Box2DSprite.h"


@interface Platform : Box2DSprite {
    b2World *world;
    
    CCSpriteFrame *standingFrame;
}

-(id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location ofType:(PlatformType)platformType withRotation:(float)rotation;

@end