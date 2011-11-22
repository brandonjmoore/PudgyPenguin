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
    
    [[GCHelper sharedInstance] reportScore:kLeaderBoardCompletionTime score:totalScore];
    
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
#pragma mark Memory Management

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
    [highScoresDictionary release];
	[super dealloc];
}

@end
