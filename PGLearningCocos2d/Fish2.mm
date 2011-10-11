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
    fixtureDef.restitution = 0.5;
    
    body->CreateFixture(&fixtureDef);
}

- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location {
    if((self = [super init])) {
        world = theWorld;
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"FishIdle.png"]];
        [self changeState:kStateIdle];
        gameObjectType = kFishType;
        [self createBodyAtLocation:location];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void) dealloc {
    
    [super dealloc];
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    Penguin2 *penguin2 = (Penguin2*)[[self parent]getChildByTag:kPenguinSpriteTagValue];
    
    //b2Body *fishBody = self.body;
    
    if (isBodyCollidingWithObjectType(self.body, kPenguinTypeBlack)){
        [self changeState:kStateHasBeenEaten];
        [penguin2 changeState:kStateEating];
    }
    
    
    
    //if (isBodyCollidingWithObjectType(drill, kPenguinTypeBlack)) {
        
    //}
    
    //if
    //TODO: finish this method (pg 100)
    
//    if ([self numberOfRunningActions] == 0) {
//        if (self.characterState == kStateIdle) {
//            millisecondsStayingIdle = millisecondsStayingIdle + deltaTime;
//            if (millisecondsStayingIdle > kPenguinBlinkTime) {
//                [self changeState:kStateBlinking];
//                //[self changeState:kStateAngry];
//                //[self changeState:kStateMouthOpen];
//            }
//        } else if ((self.characterState != kStateIdle) && (self.characterState != kStateSatisfied)) {
//            millisecondsStayingIdle = 0.0f;
//            [self changeState:kStateIdle];
//        }
//    }
}

-(void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    
    //TODO: what are these two variables for?
    id action = nil;
    //TODO: We might be able to use movement action and new position for walking (see pg 97)
    //id movementAction = nil;
    //CGPoint newPosition;
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
