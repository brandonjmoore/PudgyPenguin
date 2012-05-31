//
//  GKAchievementNotification.m
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//  $Id$
//

#import <GameKit/GameKit.h>
#import "GKAchievementNotification.h"

#pragma mark -

@interface GKAchievementNotification(private)

- (void)animationInDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)animationOutDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)delegateCallback:(SEL)selector withObject:(id)object;

@end

#pragma mark -

@implementation GKAchievementNotification(private)

- (void)animationInDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [self delegateCallback:@selector(didShowAchievementNotification:) withObject:self];
    [self performSelector:@selector(animateOut) withObject:nil afterDelay:kGKAchievementDisplayTime];
}

- (void)animationOutDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [self delegateCallback:@selector(didHideAchievementNotification:) withObject:self];
    [self removeFromSuperview];
}

- (void)delegateCallback:(SEL)selector withObject:(id)object
{
    if (self.handlerDelegate)
    {
        if ([self.handlerDelegate respondsToSelector:selector])
        {
            [self.handlerDelegate performSelector:selector withObject:object];
        }
    }
}

@end

#pragma mark -

@implementation GKAchievementNotification

@synthesize achievement=_achievement;
@synthesize background=_background;
@synthesize handlerDelegate=_handlerDelegate;
@synthesize detailLabel=_detailLabel;
@synthesize logo=_logo;
@synthesize message=_message;
@synthesize title=_title;
@synthesize textLabel=_textLabel;

#pragma mark -

- (id)initWithAchievementDescription:(GKAchievementDescription *)achievement
{
    
    CGRect frame;
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        frame = kGKAchievementDefaultSizePad;
    } else {
        frame = kGKAchievementDefaultSizePhone;
    }
    self.achievement = achievement;
    if ((self = [self initWithFrame:frame]))
    {
    }
    return self;
}

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message
{
    CGRect frame;
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        frame = kGKAchievementDefaultSizePad;
    } else {
        frame = kGKAchievementDefaultSizePhone;
    }
    self.title = title;
    self.message = message;
    if (self == [self initWithFrame:frame])
    {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        // create the GK background
        UIImage *backgroundStretch = [[UIImage imageNamed:@"gk-notification.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f];
        UIImageView *tBackground = [[UIImageView alloc] initWithFrame:frame];
        tBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        tBackground.image = backgroundStretch;
        self.background = tBackground;
        self.opaque = NO;
        [tBackground release];
        [self addSubview:self.background];

        CGRect r1;
        CGRect r2;
        
        if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            r1 = kGKAchievementText1Pad;
            r2 = kGKAchievementText2Pad;
        } else {
            r1 = kGKAchievementText1Phone;
            r2 = kGKAchievementText2Phone;
        }

        // create the text label
        UILabel *tTextLabel = [[UILabel alloc] initWithFrame:r1];
        tTextLabel.textAlignment = UITextAlignmentCenter;
        tTextLabel.backgroundColor = [UIColor clearColor];
        tTextLabel.textColor = [UIColor whiteColor];
        tTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f];
        tTextLabel.text = NSLocalizedString(@"Achievement Unlocked", @"Achievemnt Unlocked Message");
        self.textLabel = tTextLabel;
        [tTextLabel release];

        // detail label
        UILabel *tDetailLabel = [[UILabel alloc] initWithFrame:r2];
        tDetailLabel.textAlignment = UITextAlignmentCenter;
        tDetailLabel.adjustsFontSizeToFitWidth = YES;
        tDetailLabel.minimumFontSize = 10.0f;
        tDetailLabel.backgroundColor = [UIColor clearColor];
        tDetailLabel.textColor = [UIColor whiteColor];
        tDetailLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11.0f];
        self.detailLabel = tDetailLabel;
        [tDetailLabel release];

        if (self.achievement)
        {
            self.textLabel.text = self.achievement.title;
            self.detailLabel.text = self.achievement.achievedDescription;
        }
        else
        {
            if (self.title)
            {
                self.textLabel.text = self.title;
            }
            if (self.message)
            {
                self.detailLabel.text = self.message;
            }
        }

        [self addSubview:self.textLabel];
        [self addSubview:self.detailLabel];
    }
    return self;
}

- (void)dealloc
{
    
    self.handlerDelegate = nil;
    self.logo = nil;
    
    [_achievement release];
    [_background release];
    [_detailLabel release];
    [_logo release];
    [_message release];
    [_textLabel release];
    [_title release];
    
    [super dealloc];
}


#pragma mark -

- (void)animateIn
{
    [self delegateCallback:@selector(willShowAchievementNotification:) withObject:self];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kGKAchievementAnimeTime];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDidStopSelector:@selector(animationInDidStop:finished:context:)];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.frame = kGKAchievementFrameEndPad;
    } else {
        self.frame = kGKAchievementFrameEndPhone;
    }
    
    [UIView commitAnimations];
}

- (void)animateOut
{
    [self delegateCallback:@selector(willHideAchievementNotification:) withObject:self];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kGKAchievementAnimeTime];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDidStopSelector:@selector(animationOutDidStop:finished:context:)];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.frame = kGKAchievementFrameStartPad;
    } else {
        self.frame = kGKAchievementFrameStartPhone;
    }
    [UIView commitAnimations];
}

- (void)setImage:(UIImage *)image
{
    if (image)
    {
        if (!self.logo)
        {
            UIImageView *tLogo;
            if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                tLogo = [[UIImageView alloc] initWithFrame:CGRectMake(227.0f, 36.0f, 34.0f, 34.0f)];    
            } else {
                tLogo = [[UIImageView alloc] initWithFrame:CGRectMake(7.0f, 6.0f, 34.0f, 34.0f)];
            }
                        tLogo.contentMode = UIViewContentModeCenter;
            self.logo = tLogo;
            [tLogo release];
            [self addSubview:self.logo];
        }
        self.logo.image = image;
        
        if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.textLabel.frame = kGKAchievementText1WLogoPad;
            self.detailLabel.frame = kGKAchievementText2WLogoPad;
        } else {
            self.textLabel.frame = kGKAchievementText1WLogoPhone;
            self.detailLabel.frame = kGKAchievementText2WLogoPhone;
        }
        
    }
    else
    {
        if (self.logo)
        {
            [self.logo removeFromSuperview];
        }
        
        if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.textLabel.frame = kGKAchievementText1Pad;
            self.detailLabel.frame = kGKAchievementText2Pad;
        } else {
            self.textLabel.frame = kGKAchievementText1Phone;
            self.detailLabel.frame = kGKAchievementText2Phone;
        }
    }
}

@end
