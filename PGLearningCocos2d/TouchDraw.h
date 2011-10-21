//
//  TouchDraw.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/20/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "CCNode.h"

@interface TouchDraw : CCNode {
    @private
    NSMutableArray *drawPoints;
}

@property (nonatomic, assign) NSMutableArray *drawPoints;

@end
