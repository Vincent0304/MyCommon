//
//  VZPageControl.m
//  Mahjong
//
//  Created by 穆暮 on 14-7-1.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "VZPageControl.h"

@implementation VZPageControl

+(VZPageControl *)pageControlWithMaxPage:(int)maxPage
{
    return [[self alloc] initWithMaxPage:maxPage];
}

-(id)initWithMaxPage:(int)maxPage
{
    if(self = [super init])
    {
        _maxPage = maxPage;
        
        
        
        self.radius = 4;
        self.offSize = CGSizeMake(self.radius * 4, 0);
        
        
        _brush = [CCDrawNode node];
        [self addChild:_brush];
        
        
        self.maxPage = maxPage;
        self.page = 0;
        
        
        self.defaultColor = [CCColor colorWithWhite:1.0 alpha:0.25];
        self.selectedColor = [CCColor colorWithRed:66.0f / 255.0f green:166.0f / 255.0f blue:225.0f / 255.0f alpha:1];
        self.ringColor = [CCColor colorWithWhite:1.0 alpha:1.0];
    }
    return self;
}

-(void)setDefaultColor:(CCColor *)defaultColor
{
    _defaultColor = defaultColor;
    [self updateSelf];
}

-(void)setSelectedColor:(CCColor *)selectedColor
{
    _selectedColor = selectedColor;
    [self updateSelf];
}

-(void)setRingColor:(CCColor *)ringColor
{
    _ringColor = ringColor;
    [self updateSelf];
}

-(void)setMaxPage:(int)maxPage
{
    _maxPage = maxPage;
    [self updateSelf];
}

-(void)setPage:(float)page
{
    _page = clampf(page, 0, _maxPage - 1);
    [self updateSelf];
}

-(void)updateSelf
{
    int pageless = (int)(_page + 0.0);
    int pagemore = (int)(_page + 1.0);
    
    
    float pagelesspercentage = 1.0 - (_page - pageless);
    float pagemorepercentage = 1.0 - (pagemore - _page);
    
    float radius = self.radius;
    
    [_brush clear];
    
    CGPoint start = ccp(self.contentSize.width * 0.5 - self.offSize.width * (_maxPage - 1) * 0.5,
                        self.contentSize.height * 0.5 - self.offSize.height * (_maxPage - 1) * 0.5);
    
    for (int i = 0; i < _maxPage; i++)
    {
        CCDrawNode* node = _brush;

        
        CGPoint target = ccp(start.x + self.offSize.width * i, start.y + self.offSize.height * i);
        
        [node drawDot:target radius:radius color:self.defaultColor];
        if(i == pageless)
        {
            [node drawDot:target radius:radius * 1.00 * pagelesspercentage color:self.ringColor];
            [node drawDot:target radius:radius * 0.75 * pagelesspercentage color:self.selectedColor];
        }
        
        if(i == pagemore)
        {
            [node drawDot:target radius:radius * 1.00 * pagemorepercentage color:self.ringColor];
            [node drawDot:target radius:radius * 0.75 * pagemorepercentage color:self.selectedColor];
        }
    }
}

@end
