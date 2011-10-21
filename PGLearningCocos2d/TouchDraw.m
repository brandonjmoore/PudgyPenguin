//
//  TouchDraw.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/20/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "TouchDraw.h"

@implementation TouchDraw

@synthesize drawPoints;

-(id) init {
    self = [super init];
    glEnable(GL_LINES);
    glLineWidth(1.0f);
    return self;
}

-(void) draw {
    if (drawPoints && [drawPoints count] < 2) {
        //Not enough points to draw  a line
        return;
    }
    
    for (unsigned int i = 0; i < [drawPoints count]; i += 2) {
        CGPoint first = CGPointFromString([drawPoints objectAtIndex:i]);
        CGPoint second = CGPointFromString([drawPoints objectAtIndex:i + 1]);
        ccDrawLine(first, second);
    }
}

@end
