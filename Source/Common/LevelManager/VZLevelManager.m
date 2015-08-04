//
//  LevelManager.m
//  unblock
//
//  Created by 张朴军 on 12-12-25.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import "VZLevelManager.h"
#import "cocos2d.h"
#import "VZUserDefault.h"



@implementation VZLevelManager


VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZLevelManager)

-(id)init
{
    if(self = [super init])
    {
        if(![[VZUserDefault sharedVZUserDefault] objectForKey:@"LevelData"])
        {
            NSMutableDictionary* InitialDictionary = [NSMutableDictionary dictionary];
            [[VZUserDefault sharedVZUserDefault] setObject:InitialDictionary forKey:@"LevelData"];
        }
        
        NSMutableDictionary* dictionary = [[VZUserDefault sharedVZUserDefault] objectForKey:@"LevelData"];

        for (int i = 0; i < VZ_LEVEL_MAX_LEVELS; i++)
        {
            NSString* LevelIdentifier = [NSString stringWithFormat:@"Level%d",i];
            NSData *data = [dictionary objectForKey:LevelIdentifier];
            if(!data)
            {
                VZLevelItem* item = [VZLevelItem item];
                if (i == 0)
                {
                    item.state = 1;
                }
                else
                {
                    item.state = 1;
                }
                [dictionary setObject:item forKey:LevelIdentifier];
            }
        }
        [[VZUserDefault sharedVZUserDefault] setObject:dictionary forKey:@"LevelData"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
        [self load];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)load
{
    self.dictionary = [[VZUserDefault sharedVZUserDefault] objectForKey:@"LevelData"];
}

-(void)save
{
    [[VZUserDefault sharedVZUserDefault] setObject:self.dictionary forKey:@"LevelData"];
    [[VZUserDefault sharedVZUserDefault] synchronize];
}

-(VZLevelItem *)itemWithLevel:(int)level
{
    VZLevelItem* item = [self.dictionary objectForKey:[NSString stringWithFormat:@"Level%d",level]];
    return item;
}
@end
