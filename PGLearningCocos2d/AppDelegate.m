//
//  AppDelegate.m
//  PGLearningCocos2d
//
//  Created by Brandon Moore on 10/1/11.
//  Copyright Vaux 2011. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "GameManager.h"
#import "FlurryAnalytics.h"
#import "GCHelper.h"

@implementation AppDelegate

@synthesize window;
@synthesize highScoresDictionary;
@synthesize viewController;
@synthesize facebook;

#pragma mark -
#pragma mark Misc Startup

- (void) removeStartupFlicker
{
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
    //This method is required by Cocos2d
#endif
}

void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
}

#pragma mark -
#pragma mark Default Settings


- (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        CCLOG(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    [defaultsToRegister release];
}    

#pragma mark -
#pragma mark Application Run Cycle

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    
    //Analytics
    [[GCHelper sharedInstance] authenticateLocalUser];
    
    //Facebook
    facebook = [[Facebook alloc] initWithAppId:kFacebookAppID andDelegate:self];

    //Turn music on/off
    NSNumber *ismusicon = [[NSUserDefaults standardUserDefaults] objectForKey:@"ismusicon"];
    if(ismusicon == NULL) {
        [self registerDefaultsFromSettingsBundle];
    }
    
    //Load high scores
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"HighScores.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        highScoresDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    } else {
        highScoresDictionary = [[NSMutableDictionary alloc] init]; 
    }

    
    //Register for crashes (to be reported to flurry)
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	[FlurryAnalytics startSession:@"RA7ILRNLYR732NDRBEBE"];
    
    // Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
	// Removes the startup flicker
	[self removeStartupFlicker];
	
	// Start the game!
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

#pragma mark -
#pragma mark High Score Methods

-(void)setHighScore:(NSNumber*)highScore forLevel:(NSInteger)level {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"HighScores.plist"];
    
    NSString *key = [NSString stringWithFormat:@"HighScore - %d", level];
    
    NSNumber *value = [highScoresDictionary objectForKey:key];
    
    
    if (value == nil || [highScore compare:[highScoresDictionary objectForKey:key]] == NSOrderedDescending) {
        [highScoresDictionary setObject:highScore forKey:key];
        [highScoresDictionary writeToFile:path atomically:YES];
    }
    
    
    
}

-(NSInteger)getTotalHighScore {
    NSInteger totalScore = 0;
    for (id key in highScoresDictionary) {
        
        NSNumber *tempScore = (NSNumber*)[highScoresDictionary objectForKey:key];
        totalScore = totalScore + [tempScore integerValue];
    }
    
    //TODO: Dont forget to uncomment this back before releasing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!***********************!!!!!!!!!!!!!!!!!!!!!!!!!!***********
    [[GCHelper sharedInstance] reportScore:kLeaderBoardCompletionTime score:totalScore];
    
    //TODO: Dont forget to uncomment this back before releasing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!***********************!!!!!!!!!!!!!!!!!!!!!!!!!!***********
    
    
    return totalScore;
}

-(NSInteger)getHighScoreForLevel:(NSInteger)level {
    
    NSString *key = [NSString stringWithFormat:@"HighScore - %d", level];
    NSNumber *score = [highScoresDictionary objectForKey:key];
    
    return [score integerValue];
}

-(void)clearAllHighScores {
    [highScoresDictionary removeAllObjects];
}

#pragma mark -
#pragma mark Facebook Stuff

-(void)saveFacebookParams:(NSMutableDictionary*) parameters {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FacebookParams.plist"];
    
    [parameters writeToFile:path atomically:YES];
    
}

-(NSMutableDictionary*)getFacebookParameters {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FacebookParams.plist"];

    NSMutableDictionary *retrievedFacebookParams = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]autorelease];
    return retrievedFacebookParams;
}

-(void)eraseFacebookParametersFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FacebookParams.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL fileExists = [fileManager fileExistsAtPath:path];
    if (fileExists) {
        BOOL success = [fileManager removeItemAtPath:path error:&error];
        if (!success) {
            CCLOG(@"Could not delete FacebookParams.plist: %@", [error localizedDescription]);
        }
    }
    
}

-(void)doFacebookStuff:(NSMutableDictionary*)parameters {
    
    
    //check for previously saved access token information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    //Check for a valid session and if it is not valid call the authorize method which will both log the user in and prompt the user to authorize the app
    if (![facebook isSessionValid]) {
        //Save parameters so they can be accessed when we re-enter the app
        [self saveFacebookParams:parameters];
        [facebook authorize:nil];
    } else {
        [facebook dialog:@"feed" andParams:parameters andDelegate:self];
    }
}

// Pre 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [facebook handleOpenURL:url]; 
}

// For 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [facebook dialog:@"feed" andParams:[self getFacebookParameters] andDelegate:self];
    [self eraseFacebookParametersFile];
}

- (void)fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}

- (void)dialogDidComplete:(FBDialog *)dialog {
    [FlurryAnalytics logEvent:@"Submitted Facebook Dialog"];
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error {
    CCLOG(@"The post failed: %@", error.description);
    [FlurryAnalytics logEvent:@"Facebook Post Failed"];
}

- (void)dialogDidNotComplete:(FBDialog *)dialog {
    CCLOG(@"dialogDidNotComplete");
    [FlurryAnalytics logEvent:@"Cancelled Facebook Dialog"];
}

- (void)dialogDidNotCompleteWithUrl:(NSURL *)url {
    CCLOG(@"dialogDidNotCompleteWithURL");
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    [FlurryAnalytics logEvent:@"Cancelled Facebook Login"];
    CCLOG(@"User cancelled Facebook login");
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt {
    CCLOG(@"Facebook access token was extended");
}

- (void)fbSessionInvalidated {
    CCLOG(@"Facebook Session was invalidated");
}


#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
    [highScoresDictionary release];
    [facebook release];
	[super dealloc];
}

@end
