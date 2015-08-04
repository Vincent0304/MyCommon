//
//  VZInterstitialAdmob.m
//  Unblock
//
//  Created by VincentZhang on 15/8/3.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZInterstitialAdmob.h"
#import "VZInterstitialManager.h"
@implementation VZInterstitialAdmob

-(instancetype)init
{
    if(self = [super init])
    {
        self.platform = VZPlatformAdmob;
    }
    return self;
}


-(GADRequest *)createRequest
{
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as
    // well as any devices you want to receive test ads.
    request.testDevices =
    [NSArray arrayWithObjects:
     // TODO: Add your device/simulator test identifiers here. They are
     // printed to the console when the app is launched.
     nil];
    return request;
}

-(void)cacheInterstitial
{
    if(!self.isConfiged)
        return;
    
    if([[VZReachability sharedVZReachability] currentReachabilityStatus] == NotReachable)
        return;
    
    self.interstitialAd.delegate = nil;
    self.interstitialAd = nil;
    
    self.interstitialAd = [[GADInterstitial alloc] initWithAdUnitID:self.identifer];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadRequest: [self createRequest]];
}


- (void)config
{
    self.identifer = @"ca-app-pub-9629627107909508/9955672275";
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
    if(self.interstitialAd.isReady)
    {
        [self.interstitialAd presentFromRootViewController:[CCDirector sharedDirector]];
        self.displayTimes++;
        NSLog(@"[%s]",__FUNCTION__);
    }
    else
    {
        [self cacheInterstitial];
        CCLOG(@"[AdmobInterstitial]: No Content to show");
    }
}

-(BOOL)isReady:(VZLocation)location
{
    return self.interstitialAd.isReady;
}

// 加载失败
- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error
{
    //[self GADCycleInterstitial];
    
    [self performSelector:@selector(cacheInterstitial) withObject:self afterDelay:10];
    CCLOG(@"[AdmobInterstitial]: Faild to load Interstital: %@", error);
}

// 加载成功
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
    CCLOG(@"[AdmobInterstitial]: Interstital has loaded.");
}

// 广告消失
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    [self cacheInterstitial];
    //[[CCDirector sharedDirector] resume];
}

// 即将展示
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad
{
    [[VZInterstitialManager sharedVZInterstitialManager] pauseDirector];
}

// 即将消失
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{   
    [[VZInterstitialManager sharedVZInterstitialManager] resumeDirector];
}

// 即将离开应用
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad
{
    
}

@end
