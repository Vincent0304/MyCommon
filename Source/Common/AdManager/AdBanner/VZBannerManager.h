//
//  ADBannerManager.h
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-22.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZCommonDefine.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <iAd/iAd.h>
#import <iAd/ADBannerView.h>

extern NSString * const kVZBannerManagerDidLoadAd;
extern NSString * const kVZBannerManagerDidFailToReceiveAd;



extern NSString *const kVZADBannerData;
extern NSString *const kVZADBannerFirstUseDate;
extern NSString *const kVZADBannerPublishDate;

extern NSString *const kVZADBannerIsEnabled;



@class GADBannerView, GADRequest;

typedef NS_ENUM(NSUInteger, VZBannerMode)
{
    VZBanner_None       = 0,
    VZBanner_IAD        = 1,
    VZBanner_GAD        = 2,
    VZBanner_IAD_GAD    = 3,
};

@interface VZBannerManager : NSObject <ADBannerViewDelegate,GADBannerViewDelegate>
{
    BOOL                _GADHasLoaded;
    
    BOOL                _alreadyCreated;
    
}

VZ_DECLARE_SINGLETON_FOR_CLASS(VZBannerManager)

@property (nonatomic, strong)NSTimer* timer;

@property (nonatomic, strong)NSMutableDictionary* dictionary;

@property (nonatomic, assign)BOOL isAdPositionAtTop;
@property (nonatomic, assign)VZBannerMode mode;
@property (nonatomic, assign)BOOL allowToShow;

@property (nonatomic, strong)UIViewController* rootViewController;

@property (nonatomic, strong)GADBannerView* GADView;
@property (nonatomic, strong)NSString* GAD_ID;

@property (nonatomic, strong)ADBannerView* IADView;
@property (nonatomic, strong)NSString* IAD_ID;

@property (nonatomic, assign)BOOL isIADEnable;
@property (nonatomic, assign)BOOL isGADEnable;
@property (nonatomic, readonly)BOOL hadAdShowing;
@property (nonatomic, assign)float daysUntilPublish;

-(void)setIADEnable:(BOOL)isEnable Animated:(BOOL)animated;
-(void)setGADEnable:(BOOL)isEnable Animated:(BOOL)animated;

-(void)remove;
-(void)load;
-(void)save;

-(BOOL)isEnabled;
-(void)setIsEnabled:(BOOL)isEnable;


@end
