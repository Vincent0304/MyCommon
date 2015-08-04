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

+(NSArray *)defaultShipInfo
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:12];
    
    NSMutableDictionary* smallBoat = [NSMutableDictionary dictionaryWithCapacity:3];
    [smallBoat setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [smallBoat setObject:[NSNumber numberWithFloat:100] forKey:@"DefaultPrice"];
    [smallBoat setObject:kVZShipIdentifier_SmallBoat forKey:@"Identifer"];
    [array addObject:smallBoat];
    
    
    NSMutableDictionary* mediumBoat = [NSMutableDictionary dictionaryWithCapacity:3];
    [mediumBoat setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [mediumBoat setObject:[NSNumber numberWithFloat:200] forKey:@"DefaultPrice"];
    [mediumBoat setObject:kVZShipIdentifier_MediumBoat forKey:@"Identifer"];
    [array addObject:mediumBoat];
    

    NSMutableDictionary* interceptor = [NSMutableDictionary dictionaryWithCapacity:3];
    [interceptor setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [interceptor setObject:[NSNumber numberWithFloat:300] forKey:@"DefaultPrice"];
    [interceptor setObject:kVZShipIdentifier_Interceptor forKey:@"Identifer"];
    [array addObject:interceptor];
    
    
    NSMutableDictionary* largeBoat = [NSMutableDictionary dictionaryWithCapacity:3];
    [largeBoat setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [largeBoat setObject:[NSNumber numberWithFloat:400] forKey:@"DefaultPrice"];
    [largeBoat setObject:kVZShipIdentifier_LargeBoat forKey:@"Identifer"];
    [array addObject:largeBoat];
    
    
    NSMutableDictionary* dreadnought = [NSMutableDictionary dictionaryWithCapacity:3];
    [dreadnought setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [dreadnought setObject:[NSNumber numberWithFloat:500] forKey:@"DefaultPrice"];
    [dreadnought setObject:kVZShipIdentifier_Dreadnought forKey:@"Identifer"];
    [array addObject:dreadnought];
    
    
    NSMutableDictionary* blackPearl = [NSMutableDictionary dictionaryWithCapacity:3];
    [blackPearl setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [blackPearl setObject:[NSNumber numberWithFloat:600] forKey:@"DefaultPrice"];
    [blackPearl setObject:kVZShipIdentifier_BlakcPearl forKey:@"Identifer"];
    [array addObject:blackPearl];
    
    
    NSMutableDictionary* queenAnnesRevenge = [NSMutableDictionary dictionaryWithCapacity:3];
    [queenAnnesRevenge setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [queenAnnesRevenge setObject:[NSNumber numberWithFloat:700] forKey:@"DefaultPrice"];
    [queenAnnesRevenge setObject:kVZShipIdentifier_QueenAnnesRevenge forKey:@"Identifer"];
    [array addObject:queenAnnesRevenge];
    
    
    NSMutableDictionary* flyingDutchman = [NSMutableDictionary dictionaryWithCapacity:3];
    [flyingDutchman setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [flyingDutchman setObject:[NSNumber numberWithFloat:800] forKey:@"DefaultPrice"];
    [flyingDutchman setObject:kVZShipIdentifier_FlyingDutchman forKey:@"Identifer"];
    [array addObject:flyingDutchman];
    
    
    NSMutableDictionary* noahsArk = [NSMutableDictionary dictionaryWithCapacity:3];
    [noahsArk setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [noahsArk setObject:[NSNumber numberWithFloat:900] forKey:@"DefaultPrice"];
    [noahsArk setObject:kVZShipIdentifier_NoahsArk forKey:@"Identifer"];
    [array addObject:noahsArk];
    
    
    NSMutableDictionary* eastGold = [NSMutableDictionary dictionaryWithCapacity:3];
    [eastGold setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [eastGold setObject:[NSNumber numberWithFloat:1000] forKey:@"DefaultPrice"];
    [eastGold setObject:kVZShipIdentifier_EastGold forKey:@"Identifer"];
    [array addObject:eastGold];
    
    
    NSMutableDictionary* swan = [NSMutableDictionary dictionaryWithCapacity:3];
    [swan setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [swan setObject:[NSNumber numberWithFloat:1100] forKey:@"DefaultPrice"];
    [swan setObject:kVZShipIdentifier_Swan forKey:@"Identifer"];
    [array addObject:swan];
    
    
    NSMutableDictionary* friendship = [NSMutableDictionary dictionaryWithCapacity:3];
    [friendship setObject:[NSNumber numberWithInt:1] forKey:@"DefaultState"];
    [friendship setObject:[NSNumber numberWithFloat:1200] forKey:@"DefaultPrice"];
    [friendship setObject:kVZShipIdentifier_Friendship forKey:@"Identifer"];
    [array addObject:friendship];
    
    
    return array;
    
}

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
        NSArray* Commdities = [[VZIdentifyManager sharedVZIdentifyManager] objectForIdentifyInfoDictionaryKey:kVZIdentifyCommdities];
        for (NSDictionary* dic in Commdities)
        {
            NSString* CommodityIdentifier = [dic objectForKey:@"CommodityIdentifier"];
            NSData *data = [dictionary objectForKey:CommodityIdentifier];
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
                [dictionary setObject:item forKey:CommodityIdentifier];
            }
        }
        
        
        NSArray* shipInfos = [VZCommodityManager defaultShipInfo];
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
    NSArray* Commdities = [[VZIdentifyManager sharedVZIdentifyManager] objectForIdentifyInfoDictionaryKey:kVZIdentifyCommdities];
    for (NSDictionary* dic in Commdities)
    {
        NSString* CommodityIdentifier = [dic objectForKey:@"CommodityIdentifier"];
        float amount = [self amountWithIdentifier:CommodityIdentifier];
        CCLOG(@"Commdity:%@ Amount:%f",CommodityIdentifier, amount);
    }

}



@end
