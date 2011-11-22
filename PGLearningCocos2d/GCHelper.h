//
//  GCHelper.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/7/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//  Used to integrate with Game Center

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

#define kLeaderBoardCompletionTime @"com.vaux.PudgyPenguin.leaderboard.completion"

@interface GCHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    NSMutableArray *scoresToReport;
}

@property (retain) NSMutableArray *scoresToReport;
@property (assign) BOOL userAuthenticated;

+(GCHelper *) sharedInstance;
-(void) authenticationChanged;
-(void) authenticateLocalUser;
-(void)save;
-(id)initWithScoresToReport:(NSMutableArray *)scoresToReport;
-(void)reportScore:(NSString *)identifier score:(int)rawScore;

@end
