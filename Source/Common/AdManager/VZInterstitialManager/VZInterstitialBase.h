//
//  VZInterstitialBase.h
//  Unblock
//
//  Created by VincentZhang on 15/8/3.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZReachability.h"
#import "cocos2d.h"
typedef NSString * const VZLocation;

extern VZLocation const VZLocationStartup;
extern VZLocation const VZLocationHomeScreen;
extern VZLocation const VZLocationMainMenu;
extern VZLocation const VZLocationGameScreen;
extern VZLocation const VZLocationAchievements;
extern VZLocation const VZLocationQuests;
extern VZLocation const VZLocationPause;
extern VZLocation const VZLocationLevelStart;
extern VZLocation const VZLocationLevelComplete;
extern VZLocation const VZLocationTurnComplete;
extern VZLocation const VZLocationIAPStore;
extern VZLocation const VZLocationItemStore;
extern VZLocation const VZLocationGameOver;
extern VZLocation const VZLocationLeaderBoard;
extern VZLocation const VZLocationSettings;
extern VZLocation const VZLocationQuit;
extern VZLocation const VZLocationDefault;

typedef NSString * const VZAdPlatform;

extern VZAdPlatform const VZPlatformApple;
extern VZAdPlatform const VZPlatformAdmob;
extern VZAdPlatform const VZPlatformAdcolony;
extern VZAdPlatform const VZPlatformChartboost;

@protocol VZInterstitialProtocol<NSObject>

- (void)config;
- (void)cache;
- (void)reachabilityChanged:(NSNotification *)note;
- (void)show:(VZLocation)location;
- (BOOL)isReady:(VZLocation)location;


@end


@interface VZInterstitialBase : NSObject <VZInterstitialProtocol>
{
    
}

@property (nonatomic, strong)Reachability* internetReach;
@property (nonatomic, assign)BOOL isConfiged;
@property (nonatomic, assign)NSInteger  displayTimes;
@property (nonatomic, assign)NSInteger  priority;
@property (nonatomic, strong)VZAdPlatform platform;

@end
