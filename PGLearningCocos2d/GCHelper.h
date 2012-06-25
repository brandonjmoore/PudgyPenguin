//
//  GCHelper.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/7/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//  Used to integrate with Game Center

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

#if defined (FREEVERSION)
#define kLeaderBoardCompletionTime @"com.vaux.PudgyPenguinFree.leaderboard.completion"
#define kAchievement5BuzzerBeaters @"com.vaux.PudgyPenguinFree.achievement.5BuzzerBeaters"
#define kAchievement3Stars @"com.vaux.PudgyPenguinFree.achievement.3Stars"
#define kAchievementFBLike @"com.vaux.PudgyPenguinFree.achievement.fbLike"
#define kAchievementPostToFacebook @"com.vaux.PudgyPenguinFree.achievement.postToFacebook"
#else
#define kLeaderBoardCompletionTime @"com.vaux.PudgyPenguin.leaderboard.completion"
#define kAchievement5BuzzerBeaters @"com.vaux.PudgyPenguin.achievement.5BuzzerBeaters"
#define kAchievement3Stars @"com.vaux.PudgyPenguin.achievement.3Stars"
#define kAchievementFBLike @"com.vaux.PudgyPenguin.achievement.fbLike"
#define kAchievementPostToFacebook @"com.vaux.PudgyPenguin.achievement.postToFacebook"
#endif



@interface GCHelper : NSObject <NSCoding>{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    NSMutableArray *scoresToReport;
    NSMutableArray *achievementsToReport;
}

@property (retain) NSMutableArray *scoresToReport;
@property (retain) NSMutableArray *achievementsToReport;
@property (assign) BOOL userAuthenticated;

+(GCHelper *) sharedInstance;
-(void) authenticationChanged;
-(void) authenticateLocalUser;
-(void)save;
-(id) initWithScoresToReport:(NSMutableArray *)theScoresToReport achievementsToReport: (NSMutableArray *)theAchievementsToReport;
-(void)reportScore:(NSString *)identifier score:(int)rawScore;
-(void)reportAchievement:(NSString *)identifier percentComplete:(double)percentComplete;    

@end
