//
//  VZPageControl.h
//  Mahjong
//
//  Created by 穆暮 on 14-7-1.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//
#import "cocos2d.h"
#import "CCNode.h"

@interface VZPageControl : CCNode
{
    int _maxPage;
    
    CCDrawNode* _brush;
}

+(VZPageControl*)pageControlWithMaxPage:(int)maxPage;

@property(nonatomic, assign)int maxPage;
@property(nonatomic, assign)float page;
@property(nonatomic, assign)CGSize offSize;
@property(nonatomic, assign)float radius;

@property(nonatomic, retain)CCColor* defaultColor;
@property(nonatomic, retain)CCColor* selectedColor;
@property(nonatomic, retain)CCColor* ringColor;

@end
