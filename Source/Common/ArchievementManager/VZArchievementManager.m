//
//  VZArchievementStatistics.m
//  Mahjong
//
//  Created by 穆暮 on 14-9-10.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "VZArchievementManager.h"
#import "VZUserDefault.h"
#import "VZArchievementBase.h"
#import "VZGameCenterManager.h"

#import "VZArchievementStar.h"

@implementation VZArchievementManager

VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZArchievementManager)

-(id)init
{
    if(self = [super init])
    {
        self.dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)checkArchievemens
{
    NSEnumerator * enumeratorValue = [self.dictionary objectEnumerator];
    for (NSObject *object in enumeratorValue)
    {
        if([object isKindOfClass:[VZArchievementBase class]])
        {
            VZArchievementBase* checker = (VZArchievementBase*)object;
            [checker check];
        }
    }
}


@end
