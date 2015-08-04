//
//  LevelManager.h
//  unblock
//
//  Created by 张朴军 on 12-12-25.
//  Copyright (c) 2012年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZCommonDefine.h"
#import "VZLevelItem.h"
#define VZ_LEVEL_MAX_LEVELS 270
@interface VZLevelManager : NSObject
{
    
}

@property (nonatomic, strong)NSMutableDictionary* dictionary;

VZ_DECLARE_SINGLETON_FOR_CLASS(VZLevelManager)

-(void)load;
-(void)save;
-(VZLevelItem*)itemWithLevel:(int)level;

@end
