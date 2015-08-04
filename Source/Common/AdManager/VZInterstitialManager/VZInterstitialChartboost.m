//
//  VZInterstitialChartboost.m
//  Unblock
//
//  Created by VincentZhang on 15/8/3.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZInterstitialChartboost.h"
#import "VZInterstitialManager.h"

@implementation VZInterstitialChartboost

-(instancetype)init
{
    if(self = [super init])
    {
        self.platform = VZPlatformChartboost;
    }
    return self;
}


- (NSArray*)interstitialLocations
{
    NSMutableArray* arr = [NSMutableArray array];
    
    //[arr addObject:CBLocationStartup];
    //[arr addObject:CBLocationHomeScreen];
    [arr addObject:CBLocationMainMenu];
    [arr addObject:CBLocationGameScreen];
    //[arr addObject:CBLocationAchievements];
    //[arr addObject:CBLocationQuests];
    //[arr addObject:CBLocationPause];
    //[arr addObject:CBLocationLevelStart];
    [arr addObject:CBLocationLevelComplete];
    //[arr addObject:CBLocationTurnComplete];
    //[arr addObject:CBLocationIAPStore];
    //[arr addObject:CBLocationItemStore];
    //[arr addObject:CBLocationIAPStore];
    //[arr addObject:CBLocationGameOver];
    //[arr addObject:CBLocationLeaderBoard];
    //[arr addObject:CBLocationSettings];
    //[arr addObject:CBLocationQuit];
    
    return arr;
}

- (NSArray*)rewardedLocations
{
    NSMutableArray* arr = [NSMutableArray array];
    
    //[arr addObject:CBLocationStartup];
    //[arr addObject:CBLocationHomeScreen];
    [arr addObject:CBLocationMainMenu];
    [arr addObject:CBLocationGameScreen];
    //[arr addObject:CBLocationAchievements];
    //[arr addObject:CBLocationQuests];
    //[arr addObject:CBLocationPause];
    //[arr addObject:CBLocationLevelStart];
    [arr addObject:CBLocationLevelComplete];
    //[arr addObject:CBLocationTurnComplete];
    //[arr addObject:CBLocationIAPStore];
    //[arr addObject:CBLocationItemStore];
    //[arr addObject:CBLocationIAPStore];
    //[arr addObject:CBLocationGameOver];
    //[arr addObject:CBLocationLeaderBoard];
    //[arr addObject:CBLocationSettings];
    //[arr addObject:CBLocationQuit];
    
    return arr;
}

- (NSArray*)moreAppLocations
{
    NSMutableArray* arr = [NSMutableArray array];
    
    //[arr addObject:CBLocationStartup];
    //[arr addObject:CBLocationHomeScreen];
    [arr addObject:CBLocationMainMenu];
    [arr addObject:CBLocationGameScreen];
    //[arr addObject:CBLocationAchievements];
    //[arr addObject:CBLocationQuests];
    //[arr addObject:CBLocationPause];
    //[arr addObject:CBLocationLevelStart];
    [arr addObject:CBLocationLevelComplete];
    //[arr addObject:CBLocationTurnComplete];
    //[arr addObject:CBLocationIAPStore];
    //[arr addObject:CBLocationItemStore];
    //[arr addObject:CBLocationIAPStore];
    //[arr addObject:CBLocationGameOver];
    //[arr addObject:CBLocationLeaderBoard];
    //[arr addObject:CBLocationSettings];
    //[arr addObject:CBLocationQuit];
    
    return arr;
}

-(void)cacheInterstitial
{
    if(!self.isConfiged)
        return;
    
    if([[VZReachability sharedVZReachability] currentReachabilityStatus] == NotReachable)
        return;
    
    for (NSString* loc in [self interstitialLocations])
    {
        if(![Chartboost hasInterstitial:loc])
        {
            [Chartboost cacheInterstitial:loc];
        }
    }
}

-(void)cacheRewardedVideo
{
    if(!self.isConfiged)
        return;
    
    if([[VZReachability sharedVZReachability] currentReachabilityStatus] == NotReachable)
        return;
    
    for (NSString* loc in [self rewardedLocations])
    {
        if(![Chartboost hasRewardedVideo:loc])
        {
            [Chartboost cacheRewardedVideo:loc];
        }
    }
}

-(void)cacheMoreApps
{
    if(!self.isConfiged)
        return;

    if([[VZReachability sharedVZReachability] currentReachabilityStatus] == NotReachable)
        return;
    
    for (NSString* loc in [self moreAppLocations])
    {
        if(![Chartboost hasMoreApps:loc])
        {
            [Chartboost cacheMoreApps:loc];
        }
    }
}

- (void)config
{
    [Chartboost startWithAppId:@"55bcc15fc909a657619e21a9" appSignature:@"c8270547160f9b784c35992bc50a90b5fd8331c8" delegate:self];
    [Chartboost setAutoCacheAds:YES];
    self.isConfiged = YES;
}

-(void)cache
{
    if(!self.isConfiged)
        return;
    
    [self cacheInterstitial];
//    [self cacheMoreApps];
//    [self cacheRewardedVideo];
    
}

-(CBLocation)convertLocation:(VZLocation)vzlocation
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:20];
    [dic setObject:CBLocationStartup        forKey:VZLocationStartup];
    [dic setObject:CBLocationHomeScreen     forKey:VZLocationHomeScreen];
    [dic setObject:CBLocationMainMenu       forKey:VZLocationMainMenu];
    [dic setObject:CBLocationGameScreen     forKey:VZLocationGameScreen];
    [dic setObject:CBLocationAchievements   forKey:VZLocationAchievements];
    [dic setObject:CBLocationQuests         forKey:VZLocationQuests];
    [dic setObject:CBLocationPause          forKey:VZLocationPause];
    [dic setObject:CBLocationLevelStart     forKey:VZLocationLevelStart];
    [dic setObject:CBLocationLevelComplete  forKey:VZLocationLevelComplete];
    [dic setObject:CBLocationTurnComplete   forKey:VZLocationTurnComplete];
    [dic setObject:CBLocationIAPStore       forKey:VZLocationIAPStore];
    [dic setObject:CBLocationItemStore      forKey:VZLocationItemStore];
    [dic setObject:CBLocationGameOver       forKey:VZLocationGameOver];
    [dic setObject:CBLocationLeaderBoard    forKey:VZLocationLeaderBoard];
    [dic setObject:CBLocationSettings       forKey:VZLocationSettings];
    [dic setObject:CBLocationQuit           forKey:VZLocationQuit];
    [dic setObject:CBLocationDefault        forKey:VZLocationDefault];
    
    
    return (CBLocation)[dic objectForKey:vzlocation];
}

-(void)show:(VZLocation)location
{
    CBLocation cbLocation = [self convertLocation:location];
    
    if([Chartboost hasInterstitial:cbLocation])
    {
        [Chartboost showInterstitial:cbLocation];
        self.displayTimes++;
        NSLog(@"[%s]",__FUNCTION__);
    }
    else
    {
        NSLog(@"[%@] No Ads",NSStringFromClass([self class]));
    }
}

-(BOOL)isReady:(VZLocation)location
{
    CBLocation cbLocation = [self convertLocation:location];
    return [Chartboost hasInterstitial:cbLocation];
}

/*
 * Chartboost Delegate Methods
 *
 */


/*
 * shouldDisplayInterstitial
 *
 * This is used to control when an interstitial should or should not be displayed
 * The default is YES, and that will let an interstitial display as normal
 * If it's not okay to display an interstitial, return NO
 *
 * For example: during gameplay, return NO.
 *
 * Is fired on:
 * -Interstitial is loaded & ready to display
 */

- (BOOL)shouldDisplayInterstitial:(NSString *)location
{
    //NSLog(@"about to display interstitial at location %@", location);
    
    // For example:
    // if the user has left the main menu and is currently playing your game, return NO;
    
    // Otherwise return YES to display the interstitial
    return YES;
}


/*
 * didFailToLoadInterstitial
 *
 * This is called when an interstitial has failed to load. The error enum specifies
 * the reason of the failure
 */

- (void)didFailToLoadInterstitial:(NSString *)location withError:(CBLoadError)error
{
    switch(error)
    {
        case CBLoadErrorInternetUnavailable:
        {
            NSLog(@"[%@] Failed to load Interstitial, no Internet connection !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorInternal:
        {
            NSLog(@"[%@] Failed to load Interstitial, internal error !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorNetworkFailure:
        {
            NSLog(@"[%@] Failed to load Interstitial, network error !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorWrongOrientation:
        {
            NSLog(@"[%@] Failed to load Interstitial, wrong orientation !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorTooManyConnections:
        {
            NSLog(@"[%@] Failed to load Interstitial, too many connections !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorFirstSessionInterstitialsDisabled:
        {
            NSLog(@"[%@] Failed to load Interstitial, first session !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorNoAdFound :
        {
            NSLog(@"[%@] Failed to load Interstitial, no ad found !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorSessionNotStarted :
        {
            NSLog(@"[%@] Failed to load Interstitial, session not started !", NSStringFromClass([self class]));
        }
            break;
        case CBLoadErrorNoLocationFound :
        {
            NSLog(@"[%@] Failed to load Interstitial, missing location parameter !", NSStringFromClass([self class]));
        }
            break;
            
        default:
        {
            NSLog(@"[%@] Failed to load Interstitial, unknown error !", NSStringFromClass([self class]));
        }
    }
    
    [self performSelector:@selector(cacheInterstitial) withObject:self afterDelay:5];
}

/*
 * didCacheInterstitial
 *
 * Passes in the location name that has successfully been cached.
 *
 * Is fired on:
 * - All assets loaded
 * - Triggered by cacheInterstitial
 *
 * Notes:
 * - Similar to this is: (BOOL)hasCachedInterstitial:(NSString *)location;
 * Which will return true if a cached interstitial exists for that location
 */

- (void)didCacheInterstitial:(NSString *)location
{
    NSLog(@"[%@] Interstitial cached at location %@", NSStringFromClass([self class]), location);
}

-(void)didCacheRewardedVideo:(CBLocation)location
{
    NSLog(@"[%@] RewardedVideo cached at location %@", NSStringFromClass([self class]), location);
}

-(void)didCacheMoreApps:(CBLocation)location
{
    NSLog(@"[%@] MoreApps cached at location %@", NSStringFromClass([self class]), location);
}
/*
 * didFailToLoadMoreApps
 *
 * This is called when the more apps page has failed to load for any reason
 *
 * Is fired on:
 * - No network connection
 * - No more apps page has been created (add a more apps page in the dashboard)
 * - No publishing campaign matches for that user (add more campaigns to your more apps page)
 *  -Find this inside the App > Edit page in the Chartboost dashboard
 */

- (void)didFailToLoadMoreApps:(CBLoadError)error {
    switch(error){
        case CBLoadErrorInternetUnavailable: {
            NSLog(@"[%@] Failed to load More Apps, no Internet connection !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorInternal: {
            NSLog(@"[%@] Failed to load More Apps, internal error !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorNetworkFailure: {
            NSLog(@"[%@] Failed to load More Apps, network error !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorWrongOrientation: {
            NSLog(@"[%@] Failed to load More Apps, wrong orientation !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorTooManyConnections: {
            NSLog(@"[%@] Failed to load More Apps, too many connections !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorFirstSessionInterstitialsDisabled: {
            NSLog(@"[%@] Failed to load More Apps, first session !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorNoAdFound: {
            NSLog(@"[%@] Failed to load More Apps, Apps not found !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorSessionNotStarted : {
            NSLog(@"[%@] Failed to load More Apps, session not started !", NSStringFromClass([self class]));
        } break;
        default: {
            NSLog(@"[%@] Failed to load More Apps, unknown error !", NSStringFromClass([self class]));
        }
    }
    [self performSelector:@selector(cacheMoreApps) withObject:self afterDelay:5];
}

/*
 * didDismissInterstitial
 *
 * This is called when an interstitial is dismissed
 *
 * Is fired on:
 * - Interstitial click
 * - Interstitial close
 *
 */

- (void)didDismissInterstitial:(NSString *)location
{
    [[VZInterstitialManager sharedVZInterstitialManager] resumeDirector];
    //NSLog(@"dismissed interstitial at location %@", location);
}

/*
 * didDismissMoreApps
 *
 * This is called when the more apps page is dismissed
 *
 * Is fired on:
 * - More Apps click
 * - More Apps close
 *
 */

- (void)didDismissMoreApps:(NSString *)location
{
    [[VZInterstitialManager sharedVZInterstitialManager] resumeDirector];
    //NSLog(@"dismissed more apps page at location %@", location);
}

/*
 * didCompleteRewardedVideo
 *
 * This is called when a rewarded video has been viewed
 *
 * Is fired on:
 * - Rewarded video completed view
 *
 */
- (void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward
{
    [[VZInterstitialManager sharedVZInterstitialManager] resumeDirector];
    //NSLog(@"completed rewarded video view at location %@ with reward amount %d", location, reward);
}

/*
 * didFailToLoadRewardedVideo
 *
 * This is called when a Rewarded Video has failed to load. The error enum specifies
 * the reason of the failure
 */

- (void)didFailToLoadRewardedVideo:(NSString *)location withError:(CBLoadError)error {
    switch(error){
        case CBLoadErrorInternetUnavailable: {
            NSLog(@"[%@] Failed to load Rewarded Video, no Internet connection !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorInternal: {
            NSLog(@"[%@] Failed to load Rewarded Video, internal error !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorNetworkFailure: {
            NSLog(@"[%@] Failed to load Rewarded Video, network error !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorWrongOrientation: {
            NSLog(@"[%@] Failed to load Rewarded Video, wrong orientation !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorTooManyConnections: {
            NSLog(@"[%@] Failed to load Rewarded Video, too many connections !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorFirstSessionInterstitialsDisabled: {
            NSLog(@"[%@] Failed to load Rewarded Video, first session !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorNoAdFound : {
            NSLog(@"[%@] Failed to load Rewarded Video, no ad found !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorSessionNotStarted : {
            NSLog(@"[%@] Failed to load Rewarded Video, session not started !", NSStringFromClass([self class]));
        } break;
        case CBLoadErrorNoLocationFound : {
            NSLog(@"[%@] Failed to load Rewarded Video, missing location parameter !", NSStringFromClass([self class]));
        } break;
        default: {
            NSLog(@"[%@] Failed to load Rewarded Video, unknown error !", NSStringFromClass([self class]));
        }
    }
    [self performSelector:@selector(cacheRewardedVideo) withObject:self afterDelay:5];
}

/*
 * didDisplayInterstitial
 *
 * Called after an interstitial has been displayed on the screen.
 */

- (void)didDisplayInterstitial:(CBLocation)location {
    //NSLog(@"Did display interstitial");
    
    // We might want to pause our in-game audio, lets double check that an ad is visible
    if ([Chartboost isAnyViewVisible])
    {
          [[VZInterstitialManager sharedVZInterstitialManager] pauseDirector];
        // Use this function anywhere in your logic where you need to know if an ad is visible or not.
        //NSLog(@"Pause audio");
    }
}

@end
