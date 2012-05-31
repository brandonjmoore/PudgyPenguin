//
//  AppDelegate.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright Vaux 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@class RootViewController;
//@protocol FacebookReturnDelegate;

@interface AppDelegate : NSObject <UIApplicationDelegate, FBSessionDelegate, FBDialogDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    NSMutableDictionary *highScoresDictionary;
    Facebook *facebook;
    NSMutableDictionary *maxLevelDictionary;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain)NSMutableDictionary *highScoresDictionary;
@property (nonatomic, assign) RootViewController *viewController;
@property (nonatomic, assign) Facebook *facebook;
//@property(nonatomic, assign) id<FacebookReturnDelegate> facebookDelegate;

-(void)setHighScore:(NSNumber*)highScore forLevel:(NSInteger)level;
-(NSInteger)getTotalHighScore;
-(NSInteger)getHighScoreForLevel:(NSInteger)level;
-(void)clearAllHighScores;
-(void)doFacebookStuff:(NSMutableDictionary*)params;
-(NSInteger)getMaxLevelUnlocked;
-(void)saveMaxLevelUnlocked:(NSNumber*)levelNumber;

@end

//@protocol FacebookReturnDelegate <NSObject>
