//
//  Level1ActionLayer.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/18/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Constants.h"
#import "Box2DSprite.h"
#import "Box.h"
#import "Trash.h"
#import "AppDelegate.h"
#import "ActionLayer.h"


@class UILayer;
@class Penguin2;
@class Fish2;

@interface Level1ActionLayer : ActionLayer {


}

-(id)initWithLevel1UILayer:(UILayer *)level1UILayer;
        
@end
