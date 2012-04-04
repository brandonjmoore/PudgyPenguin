//
//  Level25ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/19/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "ActionLayer.h"


//@class UILayer;
//@class Penguin2;
//@class Fish2;

@interface Level25ActionLayer : ActionLayer {
    b2Body *myBody;
    ccTime lastTimeMoved;
}

-(id)initWithLevel25UILayer:(UILayer *)level25UILayer;

@end