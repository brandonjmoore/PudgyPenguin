//
//  Line.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/14/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "Line.h"

@implementation Line

- (void)createBodyAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
   // shape;
    ///shape.m_radius = self.contentSize.width/10/PTM_RATIO;
//    fixtureDef.shape = &shape;
//    
//    fixtureDef.density = 1.0;
//    fixtureDef.friction = 0.5;
//    fixtureDef.restitution = 0.5;
    
    body->CreateFixture(&fixtureDef);
}

@end
