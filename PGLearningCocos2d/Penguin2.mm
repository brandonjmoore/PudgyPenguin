//
//  Penguin.mm
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Penguin2.h"

@implementation Penguin2
//Standing, blinking, walking,
@synthesize penguinBlinkingAnim;
@synthesize penguinWalkingAnim;

//Eating Animations
@synthesize penguinOpenMouthAnim;
@synthesize penguinEatingAnim;
@synthesize penguinAngryAnim;
@synthesize penguinSatisfiedAnim;

- (void)createBodyAtLocation:(CGPoint)location {
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,  location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2CircleShape shape;
    shape.m_radius = self.contentSize.width/10/PTM_RATIO;
    fixtureDef.shape = &shape;
    
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.5;
    fixtureDef.restitution = 0.5;
    
    body->CreateFixture(&fixtureDef);
}

- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location {
    if((self = [super init])) {
        world = theWorld;
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"penguinOpenMouth_2.png"]];
        gameObjectType = kPenguinTypeBlack;
        [self createBodyAtLocation:location];
        
        millisecondsStayingIdle = 0.0f;
        millisecondsStayingAngry = 0.0f;
        [self initAnimations];
    }
    return self;
}

-(void) dealloc {
    [penguinBlinkingAnim release];
    [penguinWalkingAnim release];
    [penguinEatingAnim release];
    [penguinAngryAnim release];
    [penguinSatisfiedAnim release];
    [penguinOpenMouthAnim release];
    
    [super dealloc];
}

-(void)initAnimations {
    [self setPenguinAngryAnim:[self loadPlistForAnimationWithName:@"penguinAngryAnim" andClassName:NSStringFromClass([self class])]];
    [self setPenguinBlinkingAnim:[self loadPlistForAnimationWithName:@"penguinBlinkingAnim" andClassName:NSStringFromClass([self class])]];
    [self setPenguinOpenMouthAnim:[self loadPlistForAnimationWithName:@"penguinOpenMouthAnim" andClassName:NSStringFromClass([self class])]];
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
            CCLOG(@"Penguin->Changing State to Idle");
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"PenguinIdle.png"]];
            break;
        case kStateWalking:
            CCLOG(@"Penguin->Changing State to Walking");
            action = [CCAnimate actionWithAnimation:penguinWalkingAnim restoreOriginalFrame:YES];
            break;
        case kStateBlinking:
            CCLOG(@"Penguin->Changing State to Blinking");
            action = [CCAnimate actionWithAnimation:penguinBlinkingAnim restoreOriginalFrame:YES];
            break;
        case kStateEating:
            CCLOG(@"Penguin->Changing State to Eating");
            action = [CCAnimate actionWithAnimation:penguinEatingAnim restoreOriginalFrame:YES];
            //TODO: Here is where we increment the fishEaten count
            break;
        case kStateAngry:
            CCLOG(@"Penguin->Changing State to Angry");
            action = [CCAnimate actionWithAnimation:penguinAngryAnim restoreOriginalFrame:NO];
            break;
        case kStateSatisfied:
            CCLOG(@"Penguin->Changing State to Satisfied");
            //restoreOriginalFrame is set to no here because we want him to remain satisfied
            //action = [CCAnimate actionWithAnimation:penguinSatisfiedAnim restoreOriginalFrame:NO];
            break;
            
        case kStateMouthOpen:
            CCLOG(@"Penguin->Changing State to MouthOpen");
            //restoreOriginalFrame is set to no here because we want his mouth to remain open
            action = [CCAnimate actionWithAnimation:penguinOpenMouthAnim restoreOriginalFrame:NO];
            break;
            
        default:
            CCLOG(@"Unhandled state %d in Penguin", newState);
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    if (self.characterState == kStateSatisfied) 
        return; //Nothing to do if the Penguin is satisfied
    
    if (self.characterState == kStateMouthOpen) 
        return; //Nothing to do if the Penguin is waiting to eat
    
    CGRect myBoundingBox = [self adjustedBoundingBox];
    for (GameCharacter *character in listOfGameObjects) {
        CGRect characterBox = [character boundingBox];
        
        if (CGRectIntersectsRect(myBoundingBox, characterBox)) {
            if ([character gameObjectType] == kFishType) {
                [self changeState:kStateMouthOpen];
                [character changeState:kStateAboutToBeEaten];
            } 
        }
        
    }
    
    //if
    //TODO: finish this method (pg 100)
    
    if ([self numberOfRunningActions] == 0) {
        
        if (self.characterState == kStateIdle) {
            millisecondsStayingIdle = millisecondsStayingIdle + deltaTime;
            if (millisecondsStayingIdle > kPenguinBlinkTime) {
                [self changeState:kStateBlinking];
                //[self changeState:kStateAngry];
                //[self changeState:kStateMouthOpen];
            }
        } else if ((self.characterState != kStateIdle) && (self.characterState != kStateSatisfied)) {
            millisecondsStayingIdle = 0.0f;
            [self changeState:kStateIdle];
        }
    }
  
}

-(CGRect)adjustedBoundingBox {
    //Adjust the bounding box to the size of the sprite
    //Without transparent space
    CGRect penguinBoundingBox = [self boundingBox];
    penguinBoundingBox = CGRectMake(penguinBoundingBox.origin.x, penguinBoundingBox.origin.y, penguinBoundingBox.size.width * 1.5F, penguinBoundingBox.size.height * 1.5f);
    
    return penguinBoundingBox;
    
}





@end
