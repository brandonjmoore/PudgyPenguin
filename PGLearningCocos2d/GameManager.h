//
//  GameManager.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/7/11.
//  Copyright 2011 Vaux, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "SimpleAudioEngine.h"

@interface GameManager : NSObject {
    BOOL isMusicON;
    BOOL isSoundEffectOn;
    SceneTypes currentScene;
    
    //Added for audio
    BOOL hasAudioBeenInitialized;
    GameManagerSoundState managerSoundState;
    NSMutableDictionary *listOfSoundEffectFiles;
    NSMutableDictionary *soundEffectsState;
    SimpleAudioEngine *soundEngine;
    SceneTypes lastLevelPlayed;
    
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectOn;
@property (readwrite) GameManagerSoundState managerSoundState;
@property (nonatomic, retain) NSMutableDictionary *listOfSoundEffectFiles;
@property (nonatomic, retain) NSMutableDictionary *soundEffectsState;
@property (readwrite) SceneTypes lastLevelPlayed;



+(GameManager*)sharedGameManager;
-(void)runSceneWithID:(SceneTypes)sceneID;
-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen;
-(SceneTypes)getCurrentScene;
-(void)setupAudioEngine;
-(ALuint)playSoundEffect:(NSString*)soundEffectKey;
-(void)stopSoundEffect:(ALuint)soundEffectID;
-(void)playBackgroundTrack:(NSString*)trackFileName;

@end
