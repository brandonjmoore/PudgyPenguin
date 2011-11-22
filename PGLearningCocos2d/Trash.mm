//
//  Trash.m
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/19/11.
//  Copyright 2011 Vaux. All rights reserved.
//

#import "Trash.h"


@implementation Trash

#pragma mark -
#pragma mark Body Creation Methods

- (void)createBodyAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2CircleShape shape;
    shape.m_radius = self.contentSize.width/2/PTM_RATIO;
    fixtureDef.shape = &shape;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 0.4;
    
    body->CreateFixture(&fixtureDef);
}

- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location {
    if((self = [super init])) {
        world = theWorld;
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Scene2ButtonNormal.png"]];
        gameObjectType = kTrashType;
        [self createBodyAtLocation:location];
    }
    return self;
}

#pragma mark -
#pragma mark Mem Management

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
    //CCLOG(@"just called the trash updatestatewithdeltatime");
    //Must be included to overide method in Game Object
}

@end
