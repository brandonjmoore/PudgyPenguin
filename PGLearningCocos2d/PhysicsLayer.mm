//
//  PhysicsLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/8/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "PhysicsLayer.h"
#import "Box2DSprite.h"

@implementation PhysicsLayer

+ (id)scene {
    CCScene *scene = [CCScene node];
    PhysicsLayer *layer = [self node];
    [scene addChild:layer];
    return scene;
}

-(void)setupWorld {
    b2Vec2 gravity = b2Vec2(0.0f, -10.0f);
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
}

- (void)createBodyAtLocation:(CGPoint)location forSprite:(Box2DSprite *)sprite friction:(float32)friction restitution:(float32)restitution desity:(float32)density isBox:(BOOL)isBox {
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    bodyDef.allowSleep = false;
    b2Body *body = world->CreateBody(&bodyDef);
    body->SetUserData(sprite);
    sprite.body = body;
    
    b2FixtureDef fixtureDef;
    
    if (isBox) {
        b2PolygonShape shape;
        shape.SetAsBox(sprite.contentSize.width/2/PTM_RATIO, sprite.contentSize.height/2/PTM_RATIO);
        fixtureDef.shape = &shape;
    } else {
        b2CircleShape shape;
        //TODO: modify this so that only the penguin's mouth receives collisions (page 316)
        shape.m_radius = sprite.contentSize.width/2/PTM_RATIO;
        fixtureDef.shape = &shape;
    }
    
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    fixtureDef.restitution = restitution;
    
    body->CreateFixture(&fixtureDef);
}

- (void)setupDebugDraw {
    debugDraw = new GLESDebugDraw(PTM_RATIO *[[CCDirector sharedDirector] contentScaleFactor]);
    world->SetDebugDraw(debugDraw);
    debugDraw->SetFlags(b2DebugDraw::e_shapeBit);
}



- (id)init
{
    if ((self = [super init])) {
        [self setupWorld];
        [self setupDebugDraw];
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
    }
    
    return self;
}

-(BOOL) ccTouchBegan: (UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    b2Vec2(touchLocation.x/PTM_RATIO, touchLocation.y/PTM_RATIO);
    
    [self createBoxAtLocation:touchLocation withSize:CGSizeMake(50, 50)];
    return TRUE;
    
    
}

-(void)update:(ccTime)dt {
    
    int32 velocityIterations = 3;
    int32 positionIterations = 2;
    world->Step(dt, velocityIterations, positionIterations);
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void) draw {
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    world->DrawDebugData();
    
    glEnable(GL_TEXTURE_2D);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}

- (void)dealloc {
    if (world) {
        delete world;
        world = NULL;
    }
    if (debugDraw) {
        delete debugDraw;
        debugDraw = nil;
    }
    
    [super dealloc];
}

@end
