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
}

+(GameState *) sharedInstance;
-(void)save;

@property (assign) int numBuzzerBeaters;

@end
