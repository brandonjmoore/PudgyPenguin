//
//  Line.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/14/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Box2DSprite.h"

@interface Line : Box2DSprite {
    b2World *world;
    
    CCSpriteFrame *standingFrame;

}

- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location;

@end
