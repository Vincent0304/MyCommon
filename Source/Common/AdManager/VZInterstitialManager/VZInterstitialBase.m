//
//  VZInterstitialBase.m
//  Unblock
//
//  Created by VincentZhang on 15/8/3.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZInterstitialBase.h"

VZLocation const VZLocationStartup      = @"VZLocationStartup";
VZLocation const VZLocationHomeScreen   = @"VZLocationHomeScreen";
VZLocation const VZLocationMainMenu     = @"VZLocationMainMenu";
VZLocation const VZLocationGameScreen   = @"VZLocationGameScreen";
VZLocation const VZLocationAchievements = @"VZLocationAchievements";
VZLocation const VZLocationQuests       = @"VZLocationQuests";
VZLocation const VZLocationPause        = @"VZLocationPause";
VZLocation const VZLocationLevelStart   = @"VZLocationLevelStart";
VZLocation const VZLocationLevelComplete= @"VZLocationLevelComplete";
VZLocation const VZLocationTurnComplete = @"VZLocationTurnComplete";
VZLocation const VZLocationIAPStore     = @"VZLocationIAPStore";
VZLocation const VZLocationItemStore    = @"VZLocationItemStore";
VZLocation const VZLocationGameOver     = @"VZLocationGameOver";
VZLocation const VZLocationLeaderBoard  = @"VZLocationLeaderBoard";
VZLocation const VZLocationSettings     = @"VZLocationSettings";
VZLocation const VZLocationQuit         = @"VZLocationQuit";
VZLocation const VZLocationDefault      = @"VZLocationDefault";

VZAdPlatform const VZPlatformApple      = @"VZPlatformApple";
VZAdPlatform const VZPlatformAdmob      = @"VZPlatformAdmob";
VZAdPlatform const VZPlatformAdcolony   = @"VZPlatformAdcolony";
VZAdPlatform const VZPlatformChartboost = @"VZPlatformChartboost";


@implementation VZInterstitialBase

-(instancetype)init
{
    if(self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kVZReachabilityChangedNotification object:nil];
        self.displayTimes = 0;
        self.platform = @"unknow";
    }
    return self;
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)config
{
    
}

-(void)cache
{
    
}

- (void)reachabilityChanged:(NSNotification *)note
{
    if([[VZReachability sharedVZReachability] currentReachabilityStatus] != NotReachable)
    {
        [self cache];
    }
}

-(void)show:(VZLocation)location
{
    
}

-(BOOL)isReady:(VZLocation)location
{
    return NO;
}

@end
