//
//  VZInterstitialManager.h
//  Unblock
//
//  Created by VincentZhang on 15/8/3.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VZCommonDefine.h"
#import "VZInterstitialBase.h"
#import "VZAudioManager.h"





@interface VZInterstitialManager : NSObject
{
    
}

@property(nonatomic, strong)NSMutableDictionary* items;

@property (nonatomic, assign)NSRange intervalRange;
@property (nonatomic, assign)NSInteger showInterval;
@property (nonatomic, assign)NSInteger requestTimes;

VZ_DECLARE_SINGLETON_FOR_CLASS(VZInterstitialManager)

-(void)cache;
-(void)config;
-(void)show:(VZLocation)location;

-(void)pauseDirector;
-(void)resumeDirector;

@end
