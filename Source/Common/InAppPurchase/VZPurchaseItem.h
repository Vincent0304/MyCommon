//
//  VZProduct.h
//  Pirate
//
//  Created by VincentZhang on 15/5/10.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VZPurchaseItem : NSObject
{
    
}

+(VZPurchaseItem*)product;
@property (nonatomic, strong)NSString* purchaseIdentifer;
@property (nonatomic, strong)NSString* commodityIdentifer;
@property (nonatomic, strong)NSString* title;
@property (nonatomic, strong)NSString* detail;
@property (nonatomic, assign)float amount;

@end
