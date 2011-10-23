//
//  Box.mm
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Box.h"


@implementation Box

- (void)createNormalBoxAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape poly;
    poly.SetAsBox(self.contentSize.width/2/PTM_RATIO, self.contentSize.height/2/PTM_RATIO);
    fixtureDef.shape = &poly;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 0.5;
    
    body->CreateFixture(&fixtureDef);
}

- (void)createBouncyBoxAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape poly;
    poly.SetAsBox(self.contentSize.width/2/PTM_RATIO, self.contentSize.height/2/PTM_RATIO);
    fixtureDef.shape = &poly;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 2.0;
    
    body->CreateFixture(&fixtureDef);
}

- (void)createBalloonBoxAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2CircleShape circle;
    circle.m_radius = self.contentSize.width*0.5/PTM_RATIO;
    fixtureDef.shape = &circle;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 2.0;
    
    body->CreateFixture(&fixtureDef);
}

- (void)createPlatformBoxAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape poly;
    poly.SetAsBox(self.contentSize.width/2/PTM_RATIO, self.contentSize.height/2/PTM_RATIO);
    fixtureDef.shape = &poly;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 2.0;
    
    body->CreateFixture(&fixtureDef);
}


- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location ofType:(BoxType)boxType {
    if((self = [super init])) {
        world = theWorld;
        if (boxType == kNormalBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box.png"]];
            gameObjectType = kNormalBoxType;
            [self createNormalBoxAtLocation:location];
        } else if (boxType == kBouncyBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bouncyblock.png"]];
            gameObjectType = kBouncyBoxType;
            [self createBouncyBoxAtLocation:location];
        } else if (boxType == kBalloonBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"balloon.png"]];
            gameObjectType = kBalloonBoxType;
            [self createBalloonBoxAtLocation:location];
        } else if (boxType == kBalloonBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"balloon.png"]];
            gameObjectType = kBalloonBoxType;
            [self createBalloonBoxAtLocation:location];
        } else {
            CCLOG(@"Could not determine box type");
        }
            
    }
    return self;
}

-(void) dealloc {
    
    [super dealloc];
}

-(CGRect)adjustedBoundingBox {
    //Adjust the bounding box to the size of the sprite
    //Without transparent space
    CGRect boxBox = [self boundingBox];
    
    return boxBox;
    
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    //CCLOG(@"just called the bx updatestatewithdeltatime");

}

@end
