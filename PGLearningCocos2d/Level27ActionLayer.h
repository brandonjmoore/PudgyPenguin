//
//  Level27ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "ActionLayer.h"


//@class UILayer;
//@class Penguin2;
//@class Fish2;

@interface Level27ActionLayer : ActionLayer {
    b2Body *myBody;
    ccTime lastTimeMoved;
}

-(id)initWithLevel27UILayer:(UILayer *)level27UILayer;

@end