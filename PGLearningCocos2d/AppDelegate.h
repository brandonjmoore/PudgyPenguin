//
//  AppDelegate.h
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    NSMutableDictionary *highScoresDictionary;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain)NSMutableDictionary *highScoresDictionary;
@property (nonatomic, assign) RootViewController *viewController;

-(void)setHighScore:(NSNumber*)highScore forLevel:(NSInteger)level;
-(NSInteger)getTotalHighScore;
-(NSInteger)getHighScoreForLevel:(NSInteger)level;
-(void)clearAllHighScores;

@end
