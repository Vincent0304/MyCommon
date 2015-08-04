//
//  VZShipItem.h
//  Pirate
//
//  Created by VincentZhang on 15/7/19.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kVZShipAbilityIdentifier_Capacity;
extern NSString * const kVZShipAbilityIdentifier_MoreCard;
extern NSString * const kVZShipAbilityIdentifier_MoreSoul;
extern NSString * const kVZShipAbilityIdentifier_MoreJoker;

@interface VZShipAbilityData : NSObject

@property (nonatomic,copy) NSString* identifer;
@property (nonatomic,assign) int level;

+(NSString*)shipAbilityImageNameWithIdentifer:(NSString*)identifer;

@end

extern NSString * const kVZShipIdentifier_SmallBoat;
extern NSString * const kVZShipIdentifier_MediumBoat;
extern NSString * const kVZShipIdentifier_Interceptor;
extern NSString * const kVZShipIdentifier_LargeBoat;
extern NSString * const kVZShipIdentifier_Dreadnought;
extern NSString * const kVZShipIdentifier_BlakcPearl;
extern NSString * const kVZShipIdentifier_QueenAnnesRevenge;
extern NSString * const kVZShipIdentifier_FlyingDutchman;
extern NSString * const kVZShipIdentifier_NoahsArk;
extern NSString * const kVZShipIdentifier_EastGold;
extern NSString * const kVZShipIdentifier_Swan;
extern NSString * const kVZShipIdentifier_Friendship;

@interface VZShipDataBaseItem : NSObject<NSCoding>
{
    
}

@property(nonatomic, assign)int state;
@property(nonatomic, assign)float price;

+(VZShipDataBaseItem*)item;
+(NSArray *)defaultShipInfo;
+(NSString*)shipImageNameWithIdentifer:(NSString*)identifer;
+(NSString*)shipNameWithIdentifer:(NSString*)identifer;
+(NSString*)shipDetailWithIdentifer:(NSString*)identifer;
+(NSString*)shipImageWithIdentifer:(NSString*)identifer;
+(NSArray*)shipAbilityWithIdentifer:(NSString*)identifer;

@end
