//
//  VZConversItem.h
//  Pirate
//
//  Created by VincentZhang on 15/5/24.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VZConversItem : NSObject <NSCoding>
{
    
}

@property(nonatomic, assign)float amount;
@property(nonatomic, assign)float price;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSString* detail;

+(VZConversItem*)item;
@end
