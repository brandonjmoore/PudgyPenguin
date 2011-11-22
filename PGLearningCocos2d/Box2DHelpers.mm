//
//  Box2DHelpers.mm
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/10/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "Box2DHelpers.h"
#import "Box2DSprite.h"

#pragma mark -
#pragma mark Collision Method

bool isBodyCollidingWithObjectType(b2Body *body, GameObjectType objectType) {
    b2ContactEdge* edge = body->GetContactList();
    while (edge) {
        b2Contact* contact = edge->contact;
        if (contact->IsTouching()) {
            b2Fixture* fixtureA = contact->GetFixtureA();
            b2Fixture* fixtureB = contact->GetFixtureB();
            b2Body *bodyA = fixtureA->GetBody();
            b2Body *bodyB = fixtureB->GetBody();
            Box2DSprite *spriteA = (Box2DSprite *) bodyA->GetUserData();
            Box2DSprite *spriteB = (Box2DSprite *) bodyB->GetUserData();
            if((spriteA != NULL && spriteA.gameObjectType == objectType) || (spriteB != NULL && spriteB.gameObjectType == objectType)) {
                return true;
            }
        }
        edge = edge->next;
    }
    return false;
}
