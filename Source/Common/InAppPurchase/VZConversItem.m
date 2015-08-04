//
//  VZConversItem.m
//  Pirate
//
//  Created by VincentZhang on 15/5/24.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZConversItem.h"

NSString * const kVZPropIdentifier_Soul                 = @"pirate.soul";
NSString * const kVZPropIdentifier_Joker                = @"pirate.joker";
NSString * const kVZPropIdentifier_Bomb                 = @"pirate.bomb";
NSString * const kVZPropIdentifier_Axe                  = @"pirate.axe";
NSString * const kVZPropIdentifier_Magnet               = @"pirate.magnet";
NSString * const kVZPropIdentifier_HolyLight            = @"pirate.holy_light";
NSString * const kVZPropIdentifier_MoreCard             = @"pirate.more_card";

@implementation VZConversItem

+(VZConversItem *)item
{
    return [[self alloc] init] ;
}

+(NSArray *)defaultPropInfo
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:12];
    
    NSMutableDictionary* soul = [NSMutableDictionary dictionaryWithCapacity:5];
    [soul setObject:[NSNumber numberWithFloat:10000] forKey:@"DefaultAmount"];
    [soul setObject:[NSNumber numberWithFloat:-1] forKey:@"DefaultPrice"];
    [soul setObject:@"Soul" forKey:@"Title"];
    [soul setObject:@"It is a soul" forKey:@"Detail"];
    [soul setObject:kVZPropIdentifier_Soul forKey:@"Identifer"];
    [array addObject:soul];
    
    NSMutableDictionary* joker = [NSMutableDictionary dictionaryWithCapacity:5];
    [joker setObject:[NSNumber numberWithInt:3] forKey:@"DefaultAmount"];
    [joker setObject:[NSNumber numberWithFloat:100] forKey:@"DefaultPrice"];
    [joker setObject:@"Joker" forKey:@"Title"];
    [joker setObject:@"It is a joker" forKey:@"Detail"];
    [joker setObject:kVZPropIdentifier_Joker forKey:@"Identifer"];
    [array addObject:joker];
    
    
    NSMutableDictionary* bomb = [NSMutableDictionary dictionaryWithCapacity:5];
    [bomb setObject:[NSNumber numberWithInt:3] forKey:@"DefaultAmount"];
    [bomb setObject:[NSNumber numberWithFloat:300] forKey:@"DefaultPrice"];
    [bomb setObject:@"Bomb" forKey:@"Title"];
    [bomb setObject:@"It is a bomb" forKey:@"Detail"];
    [bomb setObject:kVZPropIdentifier_Bomb forKey:@"Identifer"];
    [array addObject:bomb];
    
    
    NSMutableDictionary* axe = [NSMutableDictionary dictionaryWithCapacity:5];
    [axe setObject:[NSNumber numberWithInt:3] forKey:@"DefaultAmount"];
    [axe setObject:[NSNumber numberWithFloat:200] forKey:@"DefaultPrice"];
    [axe setObject:@"Axe" forKey:@"Title"];
    [axe setObject:@"It is a axe" forKey:@"Detail"];
    [axe setObject:kVZPropIdentifier_Axe forKey:@"Identifer"];
    [array addObject:axe];
    
    
    NSMutableDictionary* magnet = [NSMutableDictionary dictionaryWithCapacity:5];
    [magnet setObject:[NSNumber numberWithInt:3] forKey:@"DefaultAmount"];
    [magnet setObject:[NSNumber numberWithFloat:600] forKey:@"DefaultPrice"];
    [magnet setObject:@"Magnet" forKey:@"Title"];
    [magnet setObject:@"It is a magnet" forKey:@"Detail"];
    [magnet setObject:kVZPropIdentifier_Magnet forKey:@"Identifer"];
    [array addObject:magnet];
    
    
    NSMutableDictionary* holy_light = [NSMutableDictionary dictionaryWithCapacity:5];
    [holy_light setObject:[NSNumber numberWithInt:3] forKey:@"DefaultAmount"];
    [holy_light setObject:[NSNumber numberWithFloat:400] forKey:@"DefaultPrice"];
    [holy_light setObject:@"Holy Light" forKey:@"Title"];
    [holy_light setObject:@"It is a holy light" forKey:@"Detail"];
    [holy_light setObject:kVZPropIdentifier_HolyLight forKey:@"Identifer"];
    [array addObject:holy_light];
    
    
    NSMutableDictionary* more_card = [NSMutableDictionary dictionaryWithCapacity:5];
    [more_card setObject:[NSNumber numberWithInt:3] forKey:@"DefaultAmount"];
    [more_card setObject:[NSNumber numberWithFloat:200] forKey:@"DefaultPrice"];
    [more_card setObject:@"More Card" forKey:@"Title"];
    [more_card setObject:@"It is a more card" forKey:@"Detail"];
    [more_card setObject:kVZPropIdentifier_MoreCard forKey:@"Identifer"];
    [array addObject:more_card];
    
    return array;
}

+(NSString *)propImageNameWithIdentifer:(NSString *)identifer
{
    NSString* string = @"no name";
    
    if([identifer isEqualToString:kVZPropIdentifier_Soul])
    {
        string = @"Image/Shipyard/SmallBoat.png";
    }
    else if([identifer isEqualToString:kVZPropIdentifier_Joker])
    {
        string = @"Image/Props/Joker.png";
    }
    else if([identifer isEqualToString:kVZPropIdentifier_Bomb])
    {
        string = @"Image/Props/Bomb.png";
    }
    else if([identifer isEqualToString:kVZPropIdentifier_Axe])
    {
        string = @"Image/Props/Axe.png" ;
    }
    else if([identifer isEqualToString:kVZPropIdentifier_Magnet])
    {
        string = @"Image/Props/Magnet.png";
    }
    else if([identifer isEqualToString:kVZPropIdentifier_HolyLight])
    {
        string = @"Image/Props/HolyLight.png";
    }
    else if([identifer isEqualToString:kVZPropIdentifier_MoreCard])
    {
        string = @"Image/Props/MoreCard.png";
    }
    else
    {
        
    }
    return string;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeFloat:self.amount forKey:@"amount"];
    [aCoder encodeFloat:self.price forKey:@"price"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.detail forKey:@"detail"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.amount = [aDecoder decodeFloatForKey:@"amount"];
        self.price = [aDecoder decodeFloatForKey:@"price"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.detail = [aDecoder decodeObjectForKey:@"detail"];
    }
    return self;
}

-(id)init
{
    if(self = [super init])
    {
        self.amount = 0;
        self.price = 0;
        self.title = @"title";
        self.detail = @"detail";
    }
    return self;
}

@end
