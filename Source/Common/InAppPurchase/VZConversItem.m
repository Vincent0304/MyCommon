//
//  VZConversItem.m
//  Pirate
//
//  Created by VincentZhang on 15/5/24.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZConversItem.h"

@implementation VZConversItem

+(VZConversItem *)item
{
    return [[self alloc] init] ;
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
