//
//  VZConversItem.h
//  Pirate
//
//  Created by VincentZhang on 15/5/24.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kVZPropIdentifier_Soul;
extern NSString * const kVZPropIdentifier_Joker;
extern NSString * const kVZPropIdentifier_Bomb;
extern NSString * const kVZPropIdentifier_Axe;
extern NSString * const kVZPropIdentifier_Magnet;
extern NSString * const kVZPropIdentifier_HolyLight;
extern NSString * const kVZPropIdentifier_MoreCard;

@interface VZConversItem : NSObject <NSCoding>
{
    
}

@property(nonatomic, assign)float amount;
@property(nonatomic, assign)float price;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSString* detail;

+(VZConversItem*)item;
+(NSArray *)defaultPropInfo;
+(NSString *)propImageNameWithIdentifer:(NSString *)identifer;
@end
