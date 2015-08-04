//
//  VZLevelItem.h
//  Pirate
//
//  Created by VincentZhang on 15/7/14.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VZLevelItem : NSObject <NSCoding>
{
    
}

@property(nonatomic, assign)float score;
@property(nonatomic, assign)int stars;
@property(nonatomic, assign)int state;

+(VZLevelItem*)item;


@end
