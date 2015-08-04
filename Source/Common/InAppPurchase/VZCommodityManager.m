//
//  CommodityManager.m
//  unblock
//
//  Created by 张朴军 on 13-1-18.
//  Copyright (c) 2013年 张朴军. All rights reserved.
//

#import "VZCommodityManager.h"
#import "VZInAppPurchaseManager.h"
#import "VZIdentifyManager.h"
#import "cocos2d.h"
#import "VZUserDefault.h"
#import "SecurityUtil.h"
#import "VZLevelManager.h"
#import "VZShipDataBaseItem.h"

@implementation VZCommodityManager


VZ_SYNTHESIZE_SINGLETON_FOR_CLASS(VZCommodityManager)

-(id)init
{
    if(self = [super init])
    {
        if(![[VZUserDefault sharedVZUserDefault] objectForKey:@"CommodityData"])
        {
            NSMutableDictionary* InitialDictionary = [NSMutableDictionary dictionary];
            [[VZUserDefault sharedVZUserDefault] setObject:InitialDictionary forKey:@"CommodityData"];
        }
        
        NSMutableDictionary* dictionary = [[VZUserDefault sharedVZUserDefault] objectForKey:@"CommodityData"];
        
        NSArray* propInfos = [VZConversItem defaultPropInfo];
        for (NSDictionary* dic in propInfos)
        {
            NSString* PropIdentifer = [dic objectForKey:@"Identifer"];
            NSData* data = [dictionary objectForKey:PropIdentifer];
            if(!data)
            {
                NSNumber* defaultAmount = [dic objectForKey:@"DefaultAmount"];
                NSNumber* defaultPrice = [dic objectForKey:@"DefaultPrice"];
                NSString* title = [dic objectForKey:@"Title"];
                NSString* detail = [dic objectForKey:@"Detail"];
                
                VZConversItem* item = [VZConversItem item];
                item.amount = [defaultAmount floatValue];
                item.price = [defaultPrice floatValue];
                item.title = title;
                item.detail = detail;
                [dictionary setObject:item forKey:PropIdentifer];
            }
        }
        
        
        NSArray* shipInfos = [VZShipDataBaseItem defaultShipInfo];
        for (NSDictionary* dic in shipInfos)
        {
            NSString* ShipIdentifer = [dic objectForKey:@"Identifer"];
            NSData* data = [dictionary objectForKey:ShipIdentifer];
            if(!data)
            {
                NSNumber* defaultState = [dic objectForKey:@"DefaultState"];
                NSNumber* defaultPrice = [dic objectForKey:@"DefaultPrice"];
                
                VZShipDataBaseItem* item = [VZShipDataBaseItem item];
                item.state = [defaultState intValue];
                item.price = [defaultPrice floatValue];
                [dictionary setObject:item forKey:ShipIdentifer];
            }
        }
        
        [[VZUserDefault sharedVZUserDefault] setObject:dictionary forKey:@"CommodityData"];
        
        
        self.purchaseItems = [NSMutableArray array];
        NSArray* Purchases = [[VZIdentifyManager sharedVZIdentifyManager] objectForIdentifyInfoDictionaryKey:kVZIdentifyInAppPurchases];
        for (NSDictionary* dic in Purchases)
        {
            VZPurchaseItem* product = [VZPurchaseItem product];
            product.purchaseIdentifer = [dic objectForKey:@"PurchaseIdentifier"];
            product.commodityIdentifer = [dic objectForKey:@"CommodityIdentifier"];
            product.title = [dic objectForKey:@"Title"];
            product.detail = [dic objectForKey:@"Detail"];
            product.amount = [(NSNumber*)[dic objectForKey:@"Amount"] floatValue];
            [self.purchaseItems addObject:product];
        }

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(verifyPurchase:) name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
        [self load];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)verifyPurchase:(NSNotification*)notify
{
    NSDictionary *userInfo  = [notify userInfo];
    SKPaymentTransaction* transaction = [userInfo objectForKey:@"transaction"];
    
    for (VZPurchaseItem* produtc in self.purchaseItems)
    {
        if([transaction.payment.productIdentifier isEqualToString:produtc.purchaseIdentifer])
        {
            [self setAmount:[self amountWithIdentifier:produtc.commodityIdentifer] + produtc.amount WithIndentifier:produtc.commodityIdentifer];
        }
    }
    
    [self save];
}

-(float)amountWithIdentifier:(NSString *)identifer
{
    VZConversItem *item = (VZConversItem*)[self.dictionary objectForKey:identifer];
    if(!item)
    {
        item = [VZConversItem item];
        [self.dictionary setObject:item forKey:identifer];
    }
    
    float amount = item.amount;
    return amount;
}

-(void)setAmount:(float)amount WithIndentifier:(NSString *)identifer
{
    VZConversItem *item = (VZConversItem*)[self.dictionary objectForKey:identifer];
    if(!item)
    {
        item = [VZConversItem item];
    }
    item.amount = amount;
    [self.dictionary setObject:item forKey:identifer];
    [self save];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCommodityManagerNeedUpdate object:self userInfo:nil];
}

-(float)priceWithIdentifier:(NSString *)identifer
{
    VZConversItem *item = (VZConversItem*)[self.dictionary objectForKey:identifer];
    if(!item)
    {
        item = [VZConversItem item];
        [self.dictionary setObject:item forKey:identifer];
    }
    
    float price = item.price;
    return price;
}

-(void)setPrice:(float)price WithIndentifier:(NSString *)identifer
{
    VZConversItem *item = (VZConversItem*)[self.dictionary objectForKey:identifer];
    if(!item)
    {
        item = [VZConversItem item];
    }
    item.price = price;
    [self.dictionary setObject:item forKey:identifer];
    [self save];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCommodityManagerNeedUpdate object:self userInfo:nil];
}

-(VZConversItem *)conversItemWithPurchaseIdentifer:(NSString *)identifer
{
    VZConversItem *item = (VZConversItem*)[self.dictionary objectForKey:identifer];
    return item;
}

-(VZPurchaseItem *)purchaseItemWithPurchaseIdentifer:(NSString *)identifer
{
    for (VZPurchaseItem* item in self.purchaseItems)
    {
        if ([item.purchaseIdentifer isEqualToString:identifer])
        {
            return item;
        }
    }
    return nil;
}

-(VZShipDataBaseItem *)shipDataBaseItemWithPurchaseIdentifer:(NSString *)identifer
{
    VZShipDataBaseItem *item = (VZShipDataBaseItem*)[self.dictionary objectForKey:identifer];
    return item;
}

-(void)load
{
    self.dictionary = [[VZUserDefault sharedVZUserDefault] objectForKey:@"CommodityData"];
}

-(void)save
{
    [[VZUserDefault sharedVZUserDefault] setObject:self.dictionary forKey:@"CommodityData"];
    [[VZUserDefault sharedVZUserDefault] synchronize];
}

-(void)print
{
   
}



@end
