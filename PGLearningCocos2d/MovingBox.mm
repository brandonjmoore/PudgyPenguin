//
//  MovingBox.mm
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/18/11.
//  Copyright 2011 Vaux. All rights reserved.
//

#import "MovingBox.h"


@implementation MovingBox

#pragma mark -
#pragma mark Body Creation Methods

- (b2Body*)createMovingNormalBoxAtLocation:(CGPoint)location withRotation:(float)rotation{
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    body->SetTransform((body->GetPosition()), rotation);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape poly;
    poly.SetAsBox(self.contentSize.width/2/PTM_RATIO, self.contentSize.height/2/PTM_RATIO);
    fixtureDef.shape = &poly;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 0.5;
    
    body->CreateFixture(&fixtureDef);
    return body;
}

- (b2Body*)createMovingBouncyBoxAtLocation:(CGPoint)location withRotation:(float)rotation{
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    body->SetTransform((body->GetPosition()), rotation);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape poly;
    poly.SetAsBox(self.contentSize.width/2/PTM_RATIO, self.contentSize.height/2/PTM_RATIO);
    fixtureDef.shape = &poly;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 2.0;
    
    body->CreateFixture(&fixtureDef);
    return body;
}

- (b2Body*)createMovingBalloonBoxAtLocation:(CGPoint)location withRotation:(float)rotation{
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    body->SetTransform((body->GetPosition()), rotation);
    
    b2FixtureDef fixtureDef;
    b2CircleShape circle;
    circle.m_radius = self.contentSize.width*0.5/PTM_RATIO;
    fixtureDef.shape = &circle;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 2.0;
    
    body->CreateFixture(&fixtureDef);
    return body;
}

//Create specific types of boxes
- (b2Body*)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location ofType:(MovingBoxType)movingBoxType withRotation:(float)rotation {
    b2Body *myBody;
    if((self = [super init])) {
        
        world = theWorld;
        if (movingBoxType == kMovingNormalBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box.png"]];
            gameObjectType = kMovingNormalBoxType;
            myBody = [self createMovingNormalBoxAtLocation:location withRotation:rotation];
        } else if (movingBoxType == kMovingBouncyBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bouncyblock.png"]];
            gameObjectType = kMovingBouncyBoxType;
            myBody = [self createMovingBouncyBoxAtLocation:location withRotation:rotation];
        } else if (movingBoxType == kMovingBalloonBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"balloon.png"]];
            gameObjectType = kMovingBalloonBoxType;
            myBody = [self createMovingBalloonBoxAtLocation:location withRotation:rotation];
        } else {
            CCLOG(@"Could not determine moving box type");
        }
        //Places sprite in the right position with the right rotation
        [self setRotation:(-1 * RAD_TO_DEG(rotation))];
        [self setPosition:location];
            
    }
    return myBody;
}

#pragma mark -
#pragma mark Mem Management

-(void) dealloc {
    
    [super dealloc];
}

#pragma mark -
#pragma mark Character State Methods

-(CGRect)adjustedBoundingBox {
    //Adjust the bounding box to the size of the sprite
    //Without transparent space
    CGRect boxBox = [self boundingBox];
    
    return boxBox;
    
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    //CCLOG(@"just called the movingbox updatestatewithdeltatime");

}

@end
