//
//  GameState.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 4/10/12.
//  Copyright (c) 2012 Vaux, Inc. All rights reserved.
//

#import "GameState.h"
#import "GCDatabase.h"

@implementation GameState

@synthesize numBuzzerBeaters;

static GameState *sharedInstance = nil;

+(GameState*)sharedInstance {
    @synchronized([GameState class])
    {
        if (!sharedInstance) {
            sharedInstance = [loadData(@"GameState") retain];
            if (!sharedInstance) {
                [[self alloc]init];
            }
            
        }
        return sharedInstance;
    }
    return nil;
}

+(id)alloc {
    @synchronized ([GameState class])
    {
        NSAssert(sharedInstance == nil, @"Attempted to allocate a second instance of the GameState singleton");
        sharedInstance = [super alloc];
        return sharedInstance;
    }
    return nil;
}

-(void)save {
    saveData(self, @"GameState");
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:numBuzzerBeaters forKey:@"NumBuzzerBeaters"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        numBuzzerBeaters = [aDecoder decodeIntForKey:@"NumBuzzerBeaters"];
    }
    return self;
}

@end
