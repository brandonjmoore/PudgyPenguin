//
//  Platform.mm
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Platform.h"


@implementation Platform

- (void)createNormalPlatformAtLocation:(CGPoint)location withRotation:(float)rotation {
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    body->SetTransform((body->GetPosition()), rotation);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape poly;
    poly.SetAsBox(self.contentSize.width/6/PTM_RATIO, self.contentSize.height/2/PTM_RATIO);
    fixtureDef.shape = &poly;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 0.5;
    
    body->CreateFixture(&fixtureDef);
}

- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location ofType:(PlatformType)platformType withRotation:(float)rotation {
    if((self = [super init])) {
        if (platformType == kExtraExtraLargePlatform) {
            world = theWorld;
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"icicle_xxl.png"]];
            gameObjectType = kPlatformTypeExtraExtraLarge;
            [self createNormalPlatformAtLocation:location withRotation:rotation];
        } else if (platformType == kExtraLargePlatform) {
            world = theWorld;
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"icicle_extralarge.png"]];
            gameObjectType = kPlatformTypeExtraLarge;
            [self createNormalPlatformAtLocation:location withRotation:rotation];
        } else if (platformType == kLargePlatform) {
            world = theWorld;
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"icicle_large.png"]];
            gameObjectType = kPlatformTypeLarge;
            [self createNormalPlatformAtLocation:location withRotation:rotation];
        } else if (platformType == kMediumPlatform) {
            world = theWorld;
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"icicle_medium.png"]];
            gameObjectType = kPlatformTypeMedium;
            [self createNormalPlatformAtLocation:location withRotation:rotation];
        } else if (platformType == kSmallPlatform) {
            world = theWorld;
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"icicle_small.png"]];
            gameObjectType = kPlatformTypeSmall;
            [self createNormalPlatformAtLocation:location withRotation:rotation];
        } else {
            CCLOG(@"Could not determine platform type");
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
