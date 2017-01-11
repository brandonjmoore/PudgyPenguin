//
//  Penguin.mm
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Penguin2.h"
#import "Box2DHelpers.h"
#import "GameManager.h"

@implementation Penguin2
//Standing, blinking, walking,
@synthesize penguinBlinkingAnim;
@synthesize penguinWalkingAnim;

//Eating Animations
@synthesize penguinOpenMouthAnim;
@synthesize penguinEatingAnim;
@synthesize penguinAngryAnim;
@synthesize penguinSatisfiedAnim;

@synthesize numFishEaten,numFishRequired;
@synthesize hasTimeExpired;

#pragma mark -
#pragma mark Body Creation Methods

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

//Creates the sprite and the Box2D Body
- (id)initWithWorld:(b2World *)theWorld atLocation:(CGPoint)location {
    if((self = [super init])) {
        world = theWorld;
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"PenguinIdle.png"]];
        gameObjectType = kPenguinTypeBlack;
        [self createBodyAtLocation:location];
        [self setPosition:location];
        //[self setRotation:3];
        
        millisecondsStayingIdle = 0.0f;
        millisecondsStayingAngry = 0.0f;
        [self initAnimations];
        [self setNumFishRequired:kNumOfFishReq];
    }
    return self;
}

#pragma mark -
#pragma mark Mem Management

//Dont forget to release animations
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
    [self setPenguinEatingAnim:[self loadPlistForAnimationWithName:@"penguinEatingAnim" andClassName:NSStringFromClass([self class])]];
    [self setPenguinSatisfiedAnim:[self loadPlistForAnimationWithName:@"penguinSatisfiedAnim" andClassName:NSStringFromClass([self class])]];
}

#pragma mark -
#pragma mark Penguin State Methods

//Penguin states Used for animations
-(void)changeState:(CharacterStates)newState {
    
    // TODO: This was commented out because if 
    //the penguin ate a fish he would stop moving.
    //[self stopAllActions];
    
    id action = nil;
    //TODO: We might be able to use movement action and new position for walking (see pg 97)
    //id movementAction = nil;
    //CGPoint newPosition;

        [self setCharacterState:newState];

    switch (newState) {
        case kStateIdle:
//            CCLOG(@"Penguin->Changing State to Idle");
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"PenguinIdle.png"]];
            break;
        case kStateWalking:
//            CCLOG(@"Penguin->Changing State to Walking");
            action = [CCAnimate actionWithAnimation:penguinWalkingAnim restoreOriginalFrame:YES];
            break;
        case kStateBlinking:
//            CCLOG(@"Penguin->Changing State to Blinking");
            action = [CCAnimate actionWithAnimation:penguinBlinkingAnim restoreOriginalFrame:YES];
            //This is so the penguin will still open his mouth
            //even if he is blinkingr
            [action setTag:kBlinkActionTag];
            [self changeState:kStateIdle];
            break;
        case kStateEating:
               
            //Make sure numfish is not incremented if time has expired or they have eaten the number of required fish
            //TODO: it might be better to increment fish when the collision happens, but for now, this is working.
//            CCLOG(@"Penguin->Changing State to Eating");
            if (!self.hasTimeExpired && self.numFishEaten < self.numFishRequired) {
                numFishEaten++;
            }
                
            action = [CCAnimate actionWithAnimation:penguinEatingAnim restoreOriginalFrame:YES];
            PLAYSOUNDEFFECT(FISH_EAT);
            
            //If he has eaten the necessary # of fish, make him satisfied
            if (numFishEaten >= self.numFishRequired) {
                
                [self changeState:kStateSatisfied];
            } else {
                [self changeState:kStateIdle];                
            }
            break;
        case kStateAngry:
//            CCLOG(@"Penguin->Changing State to Angry");
            //You need to stop satisfied actions or glitches occur when he is happy and eats fish
            [self stopActionByTag:kSatisfiedTag];
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"PenguinIdle.png"]];
            action = [CCAnimate actionWithAnimation:penguinAngryAnim restoreOriginalFrame:NO];
            //This keeps the penguin from eating when he is angry
            body->SetActive(NO);

            break;
        case kStateSatisfied:
//            CCLOG(@"Penguin->Changing State to Satisfied");
            [self stopActionByTag:kSatisfiedTag];
            isPenguinSatisfied = YES;
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"PenguinIdle.png"]];
            action = [CCAnimate actionWithAnimation:penguinSatisfiedAnim restoreOriginalFrame:YES];
            action = [CCRepeat actionWithAction:action times:kPenguinDanceNumber];
            [action setTag:kSatisfiedTag];
            
            //Added this so that penguin doesnt keep eating after he is satisfied.
//            self.body->SetActive(false);
            break;
            
        case kStateMouthOpen:
//            CCLOG(@"Penguin->Changing State to MouthOpen");
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

//This method is needed so that we can call change state after a delay
-(void)changeToIdle {
    //let the penguin eat again
    body->SetActive(YES);
    [self changeState:kStateIdle ];
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    if (self.characterState == kStateSatisfied) 
        return; //Nothing to do if the Penguin is satisfied
    
    if (self.characterState == kStateAngry) {
        millisecondsStayingAngry = millisecondsStayingAngry + deltaTime;
        if (millisecondsStayingAngry > kPenguinAngryTime) {
            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"penguinAngry_1.png"]];
            //TODO: Check if this causes a leak
            //This is needed to offer a smoother transition to the idle state
            [self performSelector:@selector(changeToIdle) withObject:NULL afterDelay:.05];
            //[self changeState:kStateIdle ];
            millisecondsStayingAngry = 0.0f;
        }
        return;
    }
    
    isFishCloseBy = NO;
    isTrashCloseBy = NO;
    
    // TODO: Make sure this doesnt cause problems
    //This was changed so that penguin would open his mouth while moving.
    // TODO: Make it so if he is blinking AND moving, he will still open his mouth
    if ([self numberOfRunningActions] == 0 || 
        ([self numberOfRunningActions] == 1 && [self getActionByTag:kMoveActionTag] != nil) || 
        ([self numberOfRunningActions] == 1 && [self getActionByTag:kBlinkActionTag] != nil) || 
        ([self numberOfRunningActions] == 2 && [self getActionByTag:kBlinkActionTag] != nil && [self getActionByTag:kMoveActionTag] != nil)) {
        
        //Make Penguin blink after so many seconds
        if (self.characterState == kStateIdle) {
            millisecondsStayingIdle = millisecondsStayingIdle + deltaTime;
            if (millisecondsStayingIdle > kPenguinBlinkTime) {
                [self changeState:kStateBlinking];
                millisecondsStayingIdle = 0.0f;
            }
        } else {
            millisecondsStayingIdle = 0.0f;
        }
        
        
        //Check what is close by
        CGRect myBoundingBox = [self adjustedBoundingBox];
        for (GameCharacter *character in listOfGameObjects) {
            CGRect characterBox = [character boundingBox];
            //This catches if ANYTHING (PILLAR, BOX, FISH, ICICLE, ETC.) are in penguin's bounding box
            if (CGRectIntersectsRect(myBoundingBox, characterBox)) {
                if ([character gameObjectType] == kFishType) {
                    isFishCloseBy = YES;
                    if (character.characterState != kStateAboutToBeEaten) {
                        [character changeState:kStateAboutToBeEaten];
                    }
                } else if ([character gameObjectType] == kTrashType) {
                    isTrashCloseBy = YES;
                }
            } 
        }
        
        
        //Keeping this here in case bugs come up
        //if (isFishCloseBy && (self.characterState != kStateMouthOpen) && (self.characterState != kStateSatisfied)){
        //Open penguin's mouth if fish is nearby or close mouth if fish are not near by
        if ((isFishCloseBy | isTrashCloseBy) && (self.characterState != kStateMouthOpen)) {
            [self changeState:kStateMouthOpen];
        
        } else if (self.characterState == kStateMouthOpen && !isFishCloseBy && !isTrashCloseBy) {
            if (millisecondsWithMouthOpen > kPenguinMouthOpenTime) {
                [self changeState:kStateIdle];
                millisecondsWithMouthOpen = 0.0f;
            } else {
                millisecondsWithMouthOpen = millisecondsWithMouthOpen + deltaTime;
            }
            
        }
        
        
    }
  
}

//Used to detect nearby fish
-(CGRect)adjustedBoundingBox {
    //Adjust the bounding box to the size of the sprite
    //Without transparent space
    CGRect penguinBoundingBox = [self boundingBox];
    penguinBoundingBox = CGRectMake(penguinBoundingBox.origin.x, penguinBoundingBox.origin.y, penguinBoundingBox.size.width * 1.5F, penguinBoundingBox.size.height * 1.5f);
    
    return penguinBoundingBox;
    
}

@end
