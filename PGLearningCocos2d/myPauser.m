//
//  myPauser.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 2/20/12.
//  Copyright (c) 2012 Vaux, Inc. All rights reserved.
//

#import "myPauser.h"

@implementation myPauser

+(id) scene {
    CCScene *scene = [CCScene node];
    
    myPauser *layer = [myPauser node];
    
    [scene addChild:layer];
    
    return scene;
}

@end
