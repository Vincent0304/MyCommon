//
//  ADBannerManager.m
//  Happy Jumping Bug
//
//  Created by 张朴军 on 13-4-22.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "VZBannerManager.h"
#import "VZUserDefault.h"
#import "cocos2d.h"

NSString * const kVZBannerManagerDidLoadAd = @"kVZBannerManagerDidLoadAd";
NSString * const kVZBannerManagerDidFailToReceiveAd = @"kVZBannerManagerDidFailToReceiveAd";

NSString *const kVZADBannerData = @"kVZADBannerData";
NSString *const kVZADBannerFirstUseDate = @"kVZADBannerFirstUseDate";
NSString *const kVZADBannerPublishDate = @"kVZADBannerPublishDate";
NSString *const kVZADBannerIsEnabled = @"kVZADBannerIsEnabled";

NSString *const VZADBannerPublishDate =  @"01/01/1970 00:00AM";

@implementation VZBannerManager

VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZBannerManager)

@synthesize mode = _mode;
@synthesize isAdPositionAtTop = _isAdPositionAtTop;
@synthesize rootViewController = _rootViewController;

@synthesize GADView = _GADView;
@synthesize GAD_ID = _GAD_ID;

@synthesize IADView = _IADView;
@synthesize IAD_ID = _IAD_ID;


-(id)init
{
    if(self = [super init])
    {
        if(![[VZUserDefault sharedVZUserDefault] objectForKey:kVZADBannerData])
        {
            NSMutableDictionary* InitialDictionary = [NSMutableDictionary dictionary];
            
            NSTimeInterval timeFirst = [[NSDate date] timeIntervalSince1970];
            NSNumber* firstUse = [NSNumber numberWithDouble:timeFirst];
			[InitialDictionary setObject:firstUse forKey:kVZADBannerFirstUseDate];
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [dateFormatter setLocale:usLocale];
            [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mmaaa"];
            
            NSDate* date = [dateFormatter dateFromString:VZADBannerPublishDate];
            NSTimeInterval timePublish = [date timeIntervalSince1970];
            NSNumber* publishDate = [NSNumber numberWithDouble:timePublish];
            [InitialDictionary setObject:publishDate forKey:kVZADBannerPublishDate];
            
            
            [InitialDictionary setObject:[NSNumber numberWithBool:YES] forKey:kVZADBannerIsEnabled];
            
            
            [[VZUserDefault sharedVZUserDefault] setObject:InitialDictionary forKey:kVZADBannerData];
        }
        
        
        self.dictionary = [[VZUserDefault sharedVZUserDefault] objectForKey:kVZADBannerData];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resize) name:UIDeviceOrientationDidChangeNotification object:nil];
        _GADHasLoaded = NO;
        _hadAdShowing = NO;
        _alreadyCreated = NO;
        _daysUntilPublish = 0;
        self.allowToShow = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];


    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.IADView removeFromSuperview];
    self.IADView.delegate = nil;
    self.IADView = nil;
    
    self.IAD_ID = nil;
    
    [self.GADView removeFromSuperview];
    self.GADView.delegate = nil;
    self.GADView = nil;
    self.GAD_ID = nil;
    
    self.rootViewController = nil;
}


-(void)setAllowToShow:(BOOL)allowToShow
{
    _allowToShow = allowToShow;
    
    
    switch (_mode)
    {
        case VZBanner_None:
            break;
        case VZBanner_IAD:
            if([self canDisplayIAD])
            {
                if(self.allowToShow)
                {
                    [self setIADEnable:YES Animated:YES];
                }
                else
                {
                    [self setIADEnable:NO Animated:YES];
                }
                
            }
            else
            {
                if(self.allowToShow)
                {
                    [self setGADEnable:YES Animated:YES];
                }
                else
                {
                    [self setGADEnable:NO Animated:YES];
                }
                
            }
            break;
        case VZBanner_GAD:
            if(self.allowToShow)
            {
                [self setGADEnable:YES Animated:YES];
            }
            else
            {
                [self setGADEnable:NO Animated:YES];
            }
            break;
        case VZBanner_IAD_GAD:
            if([self canDisplayIAD])
            {
                if (self.allowToShow)
                {
                    [self setIADEnable:YES Animated:YES];
                    [self setGADEnable:NO Animated:YES];
                }
                else
                {
                    [self setIADEnable:NO Animated:YES];
                    [self setGADEnable:NO Animated:YES];
                }
                
            }
            else
            {
                if(self.allowToShow)
                {
                    [self setGADEnable:YES Animated:YES];
                }
                else
                {
                    [self setGADEnable:NO Animated:YES];
                }
                
            }
            break;
    }
}

-(BOOL)isEnabled
{
    BOOL isEnable = YES;
    NSNumber* value = [self.dictionary objectForKey:kVZADBannerIsEnabled];
    isEnable = [value boolValue];
    return isEnable;
}

-(void)setIsEnabled:(BOOL)isEnable
{
    NSNumber* value = [NSNumber numberWithBool:isEnable];
    [self.dictionary setObject:value forKey:kVZADBannerIsEnabled];
}

-(BOOL)publishConditionsHaveBeenMet
{
//    if(self.isEnabled)
//    {
//        NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
//        
//        NSNumber* value = [self.dictionary objectForKey:kVZADBannerPublishDate];
//        NSTimeInterval publish = [value doubleValue];
//        if(publish <= current)
//        {
//            
//            NSNumber* number = [self.dictionary objectForKey:kVZADBannerFirstUseDate];
//            
//            NSDate *dateOfFirstLaunch = [NSDate dateWithTimeIntervalSince1970:[number doubleValue]];
//            NSTimeInterval timeSinceFirstLaunch = [[NSDate date] timeIntervalSinceDate:dateOfFirstLaunch];
//            NSTimeInterval timeUntilRate = 60 * 60 * 24 * _daysUntilPublish;
//            if (timeSinceFirstLaunch >= timeUntilRate)
//            {
//                return YES;
//            }
//        }
//    }
    
    return YES;
}

-(BOOL)hadADShowing
{
    if(self.IADView)
    {
        if(self.IADView.bannerLoaded)
            return YES;
    }
    
    if(self.GADView)
    {
        if(_GADHasLoaded)
            return YES;
    }
    return _hadAdShowing;
}

-(void)remove
{
    [self.IADView removeFromSuperview];
    self.IADView.delegate = nil;
    self.IADView = nil;
    
    [self.GADView removeFromSuperview];
    self.GADView.delegate = nil;
    self.GADView = nil;

    [self setIsEnabled:NO];
}

- (BOOL)canDisplayIAD
{
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    CCLOG(@"Country code: %@", countryCode);
    if ([countryCode isEqualToString:@"US"] || //U.S.
        [countryCode isEqualToString:@"CA"] || //Canada
        [countryCode isEqualToString:@"GB"] || //U.K.
        [countryCode isEqualToString:@"DE"] || //Germany
        [countryCode isEqualToString:@"IT"] || //Italy
        [countryCode isEqualToString:@"ES"] || //Spain
        [countryCode isEqualToString:@"FR"] || //France
        [countryCode isEqualToString:@"JP"] || //Japan
        [countryCode isEqualToString:@"NZ"] || //New Zealand
        [countryCode isEqualToString:@"AU"] || //Australia
        [countryCode isEqualToString:@"MX"] || //Mexico
        [countryCode isEqualToString:@"IE"] || //Ireland
        [countryCode isEqualToString:@"HK"] || //Hong Kong
        [countryCode isEqualToString:@"TW"]    //Taiwan
        ){
        return YES;
    }
    return NO;
}

-(void)load
{
    BOOL shouldPublishAD = [self publishConditionsHaveBeenMet];
    if(shouldPublishAD && _alreadyCreated == NO)
    {
        switch (_mode)
        {
            case VZBanner_None:
                break;
            case VZBanner_IAD:
                if([self canDisplayIAD])
                {
                    [self creatIAD];
                    if(self.allowToShow)
                    {
                        [self setIADEnable:YES Animated:NO];
                    }
                    else
                    {
                        [self setIADEnable:NO Animated:NO];
                    }
                    
                }
                else
                {
                    _mode = VZBanner_GAD;
                    [self creatGAD];
                    if(self.allowToShow)
                    {
                        [self setGADEnable:YES Animated:NO];
                    }
                    else
                    {
                        [self setGADEnable:NO Animated:NO];
                    }
                    
                }
                break;
            case VZBanner_GAD:
                [self creatGAD];
                if(self.allowToShow)
                {
                    [self setGADEnable:YES Animated:NO];
                }
                else
                {
                    [self setGADEnable:NO Animated:NO];
                }
                break;
            case VZBanner_IAD_GAD:
                if([self canDisplayIAD])
                {
                    
                    [self creatIAD];
                    [self creatGAD];
                    if (self.allowToShow)
                    {
                        [self setIADEnable:YES Animated:NO];
                        [self setGADEnable:NO Animated:NO];
                    }
                    else
                    {
                        [self setIADEnable:NO Animated:NO];
                        [self setGADEnable:NO Animated:NO];
                    }
                    
                }
                else
                {
                    _mode = VZBanner_GAD;
                    [self creatGAD];
                    if(self.allowToShow)
                    {
                        [self setGADEnable:YES Animated:NO];
                    }
                    else
                    {
                        [self setGADEnable:NO Animated:NO];
                    }
                    
                }
                break;
        }
        
        _alreadyCreated = YES;
        if(self.timer)
        {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
    else
    {
        if(self.timer == nil)
        {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(load) userInfo:nil repeats:YES];
        }
        CCLOG(@"Banner: Have not meet publish date.");
    }
}

-(void)save
{
    [[VZUserDefault sharedVZUserDefault] setObject:self.dictionary forKey:kVZADBannerData];
    [[VZUserDefault sharedVZUserDefault] synchronize];
}

#pragma mark IADBannerView Creat

-(void)creatIAD
{
    self.IADView = [[ADBannerView alloc] init];
    self.IADView.delegate = self;
    [self.rootViewController.view addSubview:self.IADView];
}

-(void)setIADEnable:(BOOL)isEnable Animated:(BOOL)animated
{
    if(self.IADView)
    {
        _isIADEnable = isEnable;
        [self layoutIADAnimated:animated];
    }
}

#pragma mark IADBannerView Adjust

- (void)layoutIADAnimated:(BOOL)animated
{
    CGRect contentFrame = self.rootViewController.view.bounds;
    CGRect bannerFrame = self.IADView.frame;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
    {
        bannerFrame.size = [self.IADView sizeThatFits:contentFrame.size];
    }
    else
    {
        bannerFrame.size = [self.IADView sizeThatFits:contentFrame.size];
    }
    
    
    
    if (_isAdPositionAtTop)
    {
        if (self.IADView.bannerLoaded && _isIADEnable)
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            bannerFrame.origin.y =  contentFrame.origin.y ;
        }
        else
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            bannerFrame.origin.y = contentFrame.origin.y - bannerFrame.size.height;
        }
        
        [UIView animateWithDuration:animated ? 0.25 : 0.0
                         animations:^{self.IADView.frame = bannerFrame;}
                         completion:^(BOOL finished){self.IADView.hidden = !_isIADEnable;}];
    }
    else
    {
        
        if (self.IADView.bannerLoaded && _isIADEnable)
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            contentFrame.size.height -= self.IADView.frame.size.height;
            bannerFrame.origin.y = contentFrame.size.height;
        }
        else
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            bannerFrame.origin.y = contentFrame.size.height;
        }
    }

    if(_isIADEnable)
    {
        self.IADView.hidden = !_isIADEnable;
        [UIView animateWithDuration:animated ? 0.25 : 0.0
                         animations:^{self.IADView.frame = bannerFrame;}
         ];
    }
    else
    {
        [UIView animateWithDuration:animated ? 0.25 : 0.0
                         animations:^{self.IADView.frame = bannerFrame;}
                         completion:^(BOOL finished){self.IADView.hidden = !_isIADEnable;}];
    }
}

#pragma mark IADBannerViewDelegate impl
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    switch (_mode)
    {
        case VZBanner_IAD:
        case VZBanner_GAD:
            break;
        case VZBanner_IAD_GAD:
        {
            if(self.allowToShow)
            {
                [self setIADEnable:YES Animated:YES];
                [self setGADEnable:NO Animated:YES];
            }
            else
            {
                [self setIADEnable:NO Animated:YES];
                [self setGADEnable:NO Animated:YES];
            }
        }
            
            break;
        default:
            break;
    }
    
    
    //[self layoutIADAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kVZBannerManagerDidLoadAd object:nil userInfo:nil];
     NSLog(@"[iAdBanner]: Banner did load.");
}
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"[iAd]: An action was started from the banner. Application will quit: %d", willLeave);
    return YES;
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"[iAd]: Action finished.");
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;
{
    switch (_mode)
    {
        case VZBanner_IAD:
        case VZBanner_GAD:
            break;
        case VZBanner_IAD_GAD:
            if(self.allowToShow)
            {
                [self setIADEnable:NO Animated:YES];
                [self setGADEnable:YES Animated:YES];
            }
            else
            {
                [self setIADEnable:NO Animated:YES];
                [self setGADEnable:NO Animated:YES];
            }
            
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kVZBannerManagerDidFailToReceiveAd object:nil userInfo:nil];
    [self layoutIADAnimated:YES];
     NSLog(@"[iAdBanner]: Faild to load the banner: %@", error);
}
- (void)adAvailabilityDidChange
{
    NSLog(@"[iAdBanner]: Ads are available! Let's display one!");
}


#pragma mark IADBannerView Creat

-(void)creatGAD
{
    self.GADView = [[GADBannerView alloc] init];
    self.GADView.adUnitID = self.GAD_ID;
    self.GADView.delegate = self;
    self.GADView.rootViewController = self.rootViewController;
    
    [self.rootViewController.view addSubview:self.GADView];
    
    _GADHasLoaded = NO;
}

-(void)requestGAD
{
    if(self.GADView && _isGADEnable)
    {
        if (self.GADView.rootViewController)
        {
            [self.GADView loadRequest:[self createRequest]];
        }
    }
}

-(void)setGADEnable:(BOOL)isEnable Animated:(BOOL)animated
{
    if(self.GADView)
    {
        if(isEnable)
        {
            if(_isGADEnable == NO)
            {
                if (self.GADView.rootViewController)
                {
                    [self.GADView loadRequest:[self createRequest]];
                }
            }
        }
        self.GADView.hidden = !isEnable;
        _isGADEnable = isEnable;
        [self layoutGADAnimated:animated];
    }
}

#pragma mark GADBannerView Adjust

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

- (void)layoutGADAnimated:(BOOL)animated
{
  
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            self.GADView.adSize = kGADAdSizeLeaderboard;
        else
            self.GADView.adSize = kGADAdSizeBanner;
    }
    else
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            self.GADView.adSize = kGADAdSizeSmartBannerLandscape;
        else
            self.GADView.adSize = kGADAdSizeSmartBannerLandscape;
    }
    
    CGRect contentFrame = self.rootViewController.view.bounds;
    CGRect bannerFrame = self.GADView.frame;
    
    if (_isAdPositionAtTop)
    {
        if (_GADHasLoaded && _isGADEnable)
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            bannerFrame.origin.y =  contentFrame.origin.y ;
        }
        else
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            bannerFrame.origin.y = contentFrame.origin.y - bannerFrame.size.height;
        }
    }
    else
    {
        if (_GADHasLoaded && _isGADEnable)
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            contentFrame.size.height -= self.GADView.frame.size.height;
            bannerFrame.origin.y = contentFrame.size.height;
        }
        else
        {
            bannerFrame.origin.x = (contentFrame.size.width - bannerFrame.size.width) * 0.5;
            bannerFrame.origin.y = contentFrame.size.height;
        }
    }
    
    if(_isGADEnable)
    {
        self.GADView.hidden = !_isGADEnable;
        [UIView animateWithDuration:animated ? 0.25 : 0.0
                         animations:^{self.GADView.frame = bannerFrame;}
         ];
    }
    else
    {
        [UIView animateWithDuration:animated ? 0.25 : 0.0
                         animations:^{self.GADView.frame = bannerFrame;}
                         completion:^(BOOL finished){self.GADView.hidden = !_isGADEnable;}];
    }
}

#pragma mark GADBannerViewDelegate impl

- (void)adViewDidReceiveAd:(GADBannerView *)adView
{
    _GADHasLoaded = YES;
    [self layoutGADAnimated:YES];
    NSLog(@"[AdmobBanner]:Banner did load");
    [[NSNotificationCenter defaultCenter] postNotificationName:kVZBannerManagerDidLoadAd object:nil userInfo:nil];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    _GADHasLoaded = NO;
    [self layoutGADAnimated:YES];
    NSLog(@"[AdmobBanner]:Failed to load the banner: %@", [error localizedFailureReason]);
    [self performSelector:@selector(requestGAD) withObject:self afterDelay:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:kVZBannerManagerDidFailToReceiveAd object:nil userInfo:nil];
}

// 在系统响应用户触摸发送者的操作而即将向其展示全屏广告用户界面时发送
- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    
}
// 在用户关闭发送者的全屏用户界面前发送
- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
    
}
// 当用户已退出发送者的全屏用户界面时发送
- (void)adViewDidDismissScreen:(GADBannerView *)adView
{
    
}
// 在应用因为用户触摸 Click-to-App-Store 或 Click-to-iTunes 横幅广告而转至后台或终止运行前发送
- (void)adViewWillLeaveApplication:(GADBannerView *)adView
{
    
}

#pragma mark ADBannerViewResizeForOrientation

-(void)resize
{
    [self layoutIADAnimated:NO];
    [self layoutGADAnimated:NO];
}
@end
