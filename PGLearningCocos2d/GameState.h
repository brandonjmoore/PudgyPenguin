//
//  GameState.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 4/10/12.
//  Copyright (c) 2012 Vaux, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject <NSCoding> {
    int numBuzzerBeaters;
    BOOL fbLike;
    BOOL allLevels3Stars;
    BOOL fbPost;
}

+(GameState *) sharedInstance;
-(void)save;

@property (assign) int numBuzzerBeaters;
@property (assign) BOOL fbLike;
@property (assign) BOOL allLevels3Stars;
@property (assign) BOOL fbPost;

@end
