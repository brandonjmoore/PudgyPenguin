//
//  GCHelper.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/7/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

#define kLeaderBoardCompletionTime @"com.vaux.PudgyPenguin.leaderboard.completion"

@interface GCHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    NSMutableArray *scoresToReport;
}

@property (retain) NSMutableArray *scoresToReport;

+(GCHelper *) sharedInstance;
-(void) authenticationChanged;
-(void) authenticateLocalUser;
-(void)save;
-(id)initWithScoresToReport:(NSMutableArray *)scoresToReport;
-(void)reportScore:(NSString *)identifier score:(int)rawScore;

@end