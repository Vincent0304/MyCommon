//
//  VZProduct.m
//  Pirate
//
//  Created by VincentZhang on 15/5/10.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZPurchaseItem.h"

@implementation VZPurchaseItem

+(VZPurchaseItem *)product
{
    return [[self alloc] init];
}
-(instancetype)init
{
    if(self = [super init])
    {
        self.purchaseIdentifer = @"purchase identifer";
        self.commodityIdentifer = @"commdity identifer";
        self.title = @"title";
        self.detail = @"detail";
        self.amount = 0;
    }
    return self;
}

@end
