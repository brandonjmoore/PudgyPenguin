//
//  Box2DSprite.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/8/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "GameCharacter.h"
#import "Box2D.h"

@interface Box2DSprite : GameCharacter {
    b2Body *body;
}

@property (assign) b2Body *body;



@end
