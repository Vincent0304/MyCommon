//
//  VZLevelItem.m
//  Pirate
//
//  Created by VincentZhang on 15/7/14.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZLevelItem.h"

@implementation VZLevelItem

+(VZLevelItem *)item
{
    return [[self alloc] init] ;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeFloat:self.score forKey:@"score"];
    [aCoder encodeInt:self.stars forKey:@"stars"];
    [aCoder encodeInt:self.state forKey:@"state"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.score = [aDecoder decodeFloatForKey:@"score"];
        self.stars = [aDecoder decodeIntForKey:@"stars"];
        self.state = [aDecoder decodeIntForKey:@"state"];
    }
    return self;
}

-(id)init
{
    if(self = [super init])
    {
        self.score = 0;
        self.stars = 0;
        self.state = 0;
    }
    return self;
}


@end
