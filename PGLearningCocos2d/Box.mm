//
//  Box.mm
//  PGLearningCocos2d
//
//  Created by Jonathan Urie on 10/18/11.
//  Copyright 2011 Vaux. All rights reserved.
//

#import "Box.h"
#import "Box2DHelpers.h"


@implementation Box

#pragma mark -
#pragma mark Body Creation Methods

- (void)createNormalBoxAtLocation:(CGPoint)location withRotation:(float)rotation {
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
}

- (void)createBouncyBoxAtLocation:(CGPoint)location withRotation:(float)rotation {
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
}

- (void)createBalloonBoxAtLocation:(CGPoint)location withRotation:(float)rotation {
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

//Create specific types of boxes
- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location ofType:(BoxType)boxType withRotation:(float)rotation {
    if((self = [super init])) {
        world = theWorld;
        if (boxType == kNormalBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"box.png"]];
            gameObjectType = kNormalBoxType;
            [self createNormalBoxAtLocation:location withRotation:rotation];
        } else if (boxType == kBouncyBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bouncyblock.png"]];
            gameObjectType = kBouncyBoxType;
            [self createBouncyBoxAtLocation:location withRotation:rotation];
        } else if (boxType == kBalloonBox) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"balloon.png"]];
            gameObjectType = kBalloonBoxType;
            [self createBalloonBoxAtLocation:location withRotation:rotation];
        } else{
            CCLOG(@"Could not determine box type");
        }
        //Places sprite in the right position
        [self setRotation:(-1 * RAD_TO_DEG(rotation))];
        [self setPosition:location];
        
        readyForWiggle = YES;
            
    }
    return self;
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
    
    if (self.gameObjectType == kBouncyBoxType | self.gameObjectType == kBalloonBoxType) {
    
        //Detect if fish collides with bouncy box
        if (isBodyCollidingWithObjectType(self.body, kFishType) | isBodyCollidingWithObjectType(self.body, kTrashType)){
            
            CCScaleTo * scaleUp = [CCScaleTo actionWithDuration:.075 scale:1.1];
            CCScaleTo * scaleDown = [CCScaleTo actionWithDuration:.075 scale:1];
            CCSequence * scaleSeq = [CCSequence actions:scaleUp, scaleDown, nil];
            
            [self runAction:scaleSeq];
            
        }
    }

}

@end
