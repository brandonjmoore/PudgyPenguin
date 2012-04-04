//
//  Level21ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "ActionLayer.h"


//@class UILayer;
//@class Penguin2;
//@class Fish2;

@interface Level21ActionLayer : ActionLayer {
    b2Body *myBody;
    ccTime lastTimeMoved;
}

-(id)initWithLevel21UILayer:(UILayer *)level21UILayer;

@end