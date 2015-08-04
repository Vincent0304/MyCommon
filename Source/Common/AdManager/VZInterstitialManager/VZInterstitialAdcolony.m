//
//  VZinterstitialAdcolony.m
//  Unblock
//
//  Created by VincentZhang on 15/8/3.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZInterstitialAdcolony.h"
#import "VZInterstitialManager.h"
@implementation VZInterstitialAdcolony

-(instancetype)init
{
    if(self = [super init])
    {
        self.locations = [NSMutableDictionary dictionaryWithCapacity:20];
        
        self.platform = VZPlatformAdcolony;
    }
    return self;
}

-(void)cacheInterstitial
{
    if(!self.isConfiged)
        return;
    
    if([[VZReachability sharedVZReachability] currentReachabilityStatus] == NotReachable)
        return;
    
//    for (NSString* loc in [self interstitialLocations])
//    {
//        if(![Chartboost hasInterstitial:loc])
//        {
//            [Chartboost cacheInterstitial:loc];
//        }
//    }
}

-(void)cacheRewardedVideo
{
    if(!self.isConfiged)
        return;
    
    if([[VZReachability sharedVZReachability] currentReachabilityStatus] == NotReachable)
        return;
    
//    for (NSString* loc in [self rewardedLocations])
//    {
//        if(![Chartboost hasRewardedVideo:loc])
//        {
//            [Chartboost cacheRewardedVideo:loc];
//        }
//    }
}

- (void)config
{
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationStartup];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationHomeScreen];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationMainMenu];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationGameScreen];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationAchievements];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationQuests];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationPause];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationLevelStart];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationLevelComplete];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationTurnComplete];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationIAPStore];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationItemStore];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationGameOver];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationLeaderBoard];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationSettings];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationQuit];
    [self.locations setObject:@"vz7483538859c7432bbf" forKey:VZLocationDefault];
    
    NSMutableSet* zoneSets = [NSMutableSet setWithCapacity:20];
    NSEnumerator* enumerator = [self.locations objectEnumerator];
    NSString* object = nil;
    while ((object = [enumerator nextObject]))
    {
        [zoneSets addObject:object];
    }
    
    
    
    NSMutableArray* zoneIDs = [NSMutableArray arrayWithCapacity:10];
    enumerator = [zoneSets objectEnumerator];
    while ((object = [enumerator nextObject]))
    {
        [zoneIDs addObject:object];
    }
    
    [AdColony configureWithAppID:@"app938a68c9113446b5bc" zoneIDs:zoneIDs delegate:self logging:YES];
    self.isConfiged = YES;
}

-(void)cache
{
    if(!self.isConfiged)
        return;
    
    [self cacheInterstitial];
}

-(void)show:(VZLocation)location
{
    
    NSString* zoneID = [self.locations objectForKey:location];
    ADCOLONY_ZONE_STATUS status = [AdColony zoneStatusForZone:zoneID];
    
    switch (status)
    {
        case ADCOLONY_ZONE_STATUS_NO_ZONE:
        {
            NSLog(@"%@ No Zone", NSStringFromClass([self class]));
        }
            break;
        case ADCOLONY_ZONE_STATUS_OFF:
        {
            NSLog(@"%@ Zone Off", NSStringFromClass([self class]));
        }
            break;
        case ADCOLONY_ZONE_STATUS_LOADING:
        {
            NSLog(@"%@ Zone Loading", NSStringFromClass([self class]));
        }
            break;
        case ADCOLONY_ZONE_STATUS_ACTIVE:
        {
            [AdColony playVideoAdForZone:zoneID withDelegate:self];
            self.displayTimes++;
            NSLog(@"[%s]",__FUNCTION__);
        }
            break;
        case ADCOLONY_ZONE_STATUS_UNKNOWN:
        {
            NSLog(@"%@ Zone Unkonw Error", NSStringFromClass([self class]));
        }
            break;
            
        default:
            break;
    }
    
    
}

-(BOOL)isReady:(VZLocation)location
{
    NSString* zoneID = [self.locations objectForKey:location];
    ADCOLONY_ZONE_STATUS status = [AdColony zoneStatusForZone:zoneID];
    return status == ADCOLONY_ZONE_STATUS_ACTIVE;
}


#pragma mark -
#pragma mark AdColony V4VC

// Callback activated when a V4VC currency reward succeeds or fails
// This implementation is designed for client-side virtual currency without a server
// It uses NSUserDefaults for persistent client-side storage of the currency balance
// For applications with a server, contact the server to retrieve an updated currency balance
// On success, posts an NSNotification so the rest of the app can update the UI
// On failure, posts an NSNotification so the rest of the app can disable V4VC UI elements
- ( void ) onAdColonyV4VCReward:(BOOL)success currencyName:(NSString*)currencyName currencyAmount:(int)amount inZone:(NSString*)zoneID
{
    NSLog(@"AdColony zone %@ reward %i %i %@", zoneID, success, amount, currencyName);
    
    if (success)
    {
        //[[NSNotificationCenter defaultCenter] postNotificationName:kVZAdcolonyCurrencyBalanceChange object:nil];
    }
    else
    {
//        _state = VZAdcolonyState_Off;
//        [[NSNotificationCenter defaultCenter] postNotificationName:kVZAdcolonyZoneOff object:nil];
    }
}

#pragma mark -
#pragma mark AdColony ad fill

- ( void ) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString*) zoneID
{
    if(available)
    {
//        _state = VZAdcolonyState_Ready;
//        [[NSNotificationCenter defaultCenter] postNotificationName:kVZAdcolonyZoneReady object:nil];
//        NSLog(@"AdColony zone %@ is ready", zoneID);
    }
    else
    {
//        _state = VZAdcolonyState_Loading;
//        [[NSNotificationCenter defaultCenter] postNotificationName:kVZAdcolonyZoneLoading object:nil];
//        NSLog(@"AdColony zone %@ is loading", zoneID);
    }
}

/**
 * Notifies your app that an ad will actually play in response to the app's request to play an ad.
 * This method is called when AdColony has taken control of the device screen and is about to begin
 * showing an ad. Apps should implement app-specific code such as pausing a game and turning off app music.
 * @param zoneID The affected zone
 */

- ( void ) onAdColonyAdStartedInZone:( NSString * )zoneID;
{
    [[VZInterstitialManager sharedVZInterstitialManager] pauseDirector];
}

/**
 * Notifies your app that an ad completed playing (or never played) and control has been returned to the app.
 * This method is called when AdColony has finished trying to show an ad, either successfully or unsuccessfully.
 * If an ad was shown, apps should implement app-specific code such as unpausing a game and restarting app music.
 * @param shown Whether an ad was actually shown
 * @param zoneID The affected zone
 */
- ( void ) onAdColonyAdAttemptFinished:(BOOL)shown inZone:( NSString * )zoneID;
{
    [[VZInterstitialManager sharedVZInterstitialManager] resumeDirector];
}


@end
