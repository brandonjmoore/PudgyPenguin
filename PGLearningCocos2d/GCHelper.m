//
//  GCHelper.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/7/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//

#import "GCHelper.h"
#import "GCDatabase.h"

@implementation GCHelper

@synthesize scoresToReport;
@synthesize userAuthenticated;

#pragma mark Loading/Saving

static GCHelper *sharedHelper = nil;
+(GCHelper *) sharedInstance {
    @synchronized([GCHelper class]) {
        if (!sharedHelper) {
            sharedHelper = [loadData(@"GameCenterData") retain];
            if (!sharedHelper) {
                [[self alloc] initWithScoresToReport:[NSMutableArray array]];
            }
        }
        return sharedHelper;
    }
    return nil;
}

+(id)alloc {
    @synchronized ([GCHelper class]) {
        NSAssert(sharedHelper == nil, @"Attempted to allocate a second instance of the GCHelper singleton");
        sharedHelper = [super alloc];
        return sharedHelper;
    }
    return nil;
}

-(void)save {
    saveData(self, @"GameCenterData");
}

-(BOOL) isGameCenterAvailable {
    //Check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    //Check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

-(id) initWithScoresToReport:(NSMutableArray *)theScoresToReport {
    if ((self = [super init])) {
        self.scoresToReport = theScoresToReport;
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
    }
    return self;
}

#pragma mark Internal Functions

-(void) sendScore:(GKScore *)score {
    [score reportScoreWithCompletionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (error == NULL) {
                NSLog(@"Successfully sent score!");
                [scoresToReport removeObject:score];
            }else {
                NSLog(@"Score failted to send...will try again later. Reason: %@", error.localizedDescription);
            }
        });
    }];
}

-(void)resendData {
    for (GKScore *score in scoresToReport) {
        [self sendScore:score];
    }
}

-(void) authenticationChanged {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
            NSLog(@"Authentication changed: player authenticated.");
            userAuthenticated = TRUE;
            [self resendData];
        } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
            NSLog(@"Authentication changed: player not authenticated");
            userAuthenticated = FALSE;
        }
    });
}

#pragma mark User Functions

-(void) authenticateLocalUser {
    if (!gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    } else {
        NSLog(@"Already authenticated.");
    }
}

-(void)reportScore:(NSString *)identifier score:(int)rawScore {
    GKScore *score = [[[GKScore alloc]initWithCategory:identifier] autorelease];
    score.value = rawScore;
    [scoresToReport addObject:score];
    [self save];
    
    if (!gameCenterAvailable || !userAuthenticated) return;
    [self sendScore:score];
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:scoresToReport forKey:@"ScoresToReport"];
}

-(id)initWithCoder:(NSCoder *)decoder {
    NSMutableArray *theScoresToReport = [decoder decodeObjectForKey:@"ScoresToReport"];
    return [self initWithScoresToReport:theScoresToReport];
}











@end
