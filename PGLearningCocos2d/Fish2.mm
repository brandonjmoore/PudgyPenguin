//
//  Fish2.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Fish2.h"
#import "Penguin2.h"
#import "Box2DHelpers.h"

@implementation Fish2

#pragma mark -
#pragma mark Body Creation Methods

- (void)createBodyAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    
    //Dont allow bodies to sleep (needed for accelerometer)
    //bodyDef.allowSleep = false;
    
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2CircleShape shape;
    shape.m_radius = self.contentSize.width*0.33/PTM_RATIO;
    fixtureDef.shape = &shape;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.25;
    fixtureDef.restitution = 0.25;
    
    //This makes it so the fish doesnt get stuck to moving objects
    body->SetBullet(true);
    body->CreateFixture(&fixtureDef);
}

- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location {
    if((self = [super init])) {
        world = theWorld;
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"FishIdle.png"]];
        [self changeState:kStateIdle];
        gameObjectType = kFishType;
        //Places sprites in the right position
        [self setPosition:location];
        [self createBodyAtLocation:location];
    }
    return self;
}

#pragma mark -
#pragma mark Mem Management

-(void) dealloc {
    CCLOG(@"fish dealloc");
    [super dealloc];
}

#pragma mark -
#pragma mark Character State Methods

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    Penguin2 *penguin2 = (Penguin2*)[[self parent]getChildByTag:kPenguinSpriteTagValue];
    
    //Detect if fish collides with penguin's mouth
    if (isBodyCollidingWithObjectType(self.body, kPenguinTypeBlack)){
            [self changeState:kStateHasBeenEaten];
            [penguin2 changeState:kStateEating];
    }

}

-(void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateIdle:
            CCLOG(@"Fish->Changing State to Idle");
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"FishIdle.png"]];
            break;
            
        case kStateHasBeenEaten:
            CCLOG(@"Fish->Changing State to hasBeenEaten");
            //Remove from parent
            if ([self numberOfRunningActions] == 0) {
                    world->DestroyBody(self.body);
                    [self setVisible:NO];
                    [self removeFromParentAndCleanup:YES];
                
            }
            break;
        case kStateAboutToBeEaten:
            CCLOG(@"Fish->Changing State to aboutToBeEaten");
            //action  = [CCAnimate actionWithAnimation:becomeScared restoreOriginalFrame:NO];
            break;    
            
        default:
            CCLOG(@"Unhandled state %d in Fish", newState);
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}





@end
