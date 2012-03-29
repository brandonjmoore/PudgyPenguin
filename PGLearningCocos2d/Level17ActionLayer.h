//
//  Level17ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "ActionLayer.h"


//@class UILayer;
//@class Penguin2;
//@class Fish2;

@interface Level17ActionLayer : ActionLayer {
    b2Body *myBody;
    ccTime lastTimeMoved;
}

-(id)initWithLevel17UILayer:(UILayer *)level17UILayer;

@end