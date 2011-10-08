//
//  LevelCompleteLayer.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import "LevelCompleteLayer.h"

@implementation LevelCompleteLayer

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CCLOG(@"Touches received, returning to the Main Menu");
	[[GameManager sharedGameManager] setHasPlayerBeenDefeated :NO]; // Reset this for the next level
    NSInteger currentScene = [[GameManager sharedGameManager] getCurrentScene];
    if (currentScene < kLastLevelNumber) {
        NSInteger nextScene = currentScene + 1;
        [[GameManager sharedGameManager] runSceneWithID:nextScene];
    } else {
        [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
    }
    
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Initialization code here.
    }
    
    return self;
}

@end
