//
//  CommodityManager.h
//  unblock
//
//  Created by 张朴军 on 13-1-18.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZCommonDefine.h"
#import "VZPurchaseItem.h"
#import "VZConversItem.h"
#import "VZShipDataBaseItem.h"
#define kCommodityManagerNeedUpdate @"kCommodityManagerNeedUpdate"
@interface VZCommodityManager : NSObject
{

}

VZ_DECLARE_SINGLETON_FOR_CLASS(VZCommodityManager)

@property (nonatomic, strong)NSMutableArray* purchaseItems;
@property (nonatomic, strong)NSMutableDictionary* dictionary;

-(float)amountWithIdentifier:(NSString*)identifer;
-(void)setAmount:(float)amount WithIndentifier:(NSString*)identifer;

-(float)priceWithIdentifier:(NSString*)identifer;
-(void)setPrice:(float)price WithIndentifier:(NSString*)identifer;

-(VZPurchaseItem*)purchaseItemWithPurchaseIdentifer:(NSString*)identifer;
-(VZConversItem*)conversItemWithPurchaseIdentifer:(NSString*)identifer;
-(VZShipDataBaseItem*)shipDataBaseItemWithPurchaseIdentifer:(NSString*)identifer;


-(void)load;
-(void)save;
-(void)print;

@end
