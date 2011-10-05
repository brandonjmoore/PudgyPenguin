//
//  GameObject.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject
@synthesize reactsToScreenBoundaries;
@synthesize screenSize;
@synthesize isActive;
@synthesize gameObjectType;

- (id)init {
    //This line calls CCSprite
    if ((self=[super init])) {
        CCLOG(@"GameObject init");
        screenSize = [CCDirector sharedDirector].winSize;
        isActive = TRUE;
        gameObjectType = kObjectTypeNone;
    }
    
    return self;
}

-(void)changeState: (CharacterStates)newState {
    CCLOG(@"GameObject->changeState method should be overridden");
}

-(void)updateStateWithDeltaTime: (ccTime)deltaTime andListOfGameObjects: (CCArray*)listOfGameObjects{
    CCLOG(@"GameObject->updateStateWithDeltaTime method should be overridden");
}

-(CGRect)adjustedBoundingBox {
    CCLOG(@"GameObject->adjustBoundingBox method should be overridden");
    return [self boundingBox];
}

//TODO: The Plists have to be named after their corresponding class (RadarDish.plist). The filename prefix is the prefix of the individual sprite. The animation frame is the file name suffix.
//This method is responsible for setting up the animations based on the data stored in plists.
-(CCAnimation*)loadPlistForAnimationWithName:(NSString *)animationName andClassName:(NSString *)className {
    
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName = [NSString stringWithFormat:@"%@.plist", className];
    NSString *plistPath;
    
    //1. Get the path to the plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    }
    
    //2. Read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    //3. If the plistDictionary was null, the file was not found
    if (plistDictionary == nil) {
        //Why not use a CCError here?
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil; // No Plist Dictionary or file found
    }
    
    //4. Get just the mini-dictionary for this animation
    NSDictionary *animationSettings = [plistDictionary objectForKey:animationName];
    if (animationSettings == nil) {
        CCLOG(@"Could not locate AnimationWithName:%@", animationName);
        return nil;
    }
    
    //5. Get the delay value for the animation
    float animationDelay = [[animationSettings objectForKey:@"delay"] floatValue];
    animationToReturn = [CCAnimation animation];
    [animationToReturn setDelay:animationDelay];
    
    //6. Add the frames to the animation
    NSString *animationFramePrefix = [animationSettings objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey:@"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
    
    for (NSString *frameNumber in animationFrameNumbers) {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix, frameNumber];
        [animationToReturn addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    
    return animationToReturn;
    
    
}

@end
