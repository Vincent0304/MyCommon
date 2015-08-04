//
//  VZInterimLayer.m
//  One Day In The Zoo
//
//  Created by 穆暮 on 14-11-3.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "VZInterimLayer.h"

@implementation VZInterimLayer

+(VZInterimLayer *)interimLayerWithRootPosition:(CGPoint)rootPosition
{
    return [[self alloc] initWithRootPosition:rootPosition];
}

-(id)initWithRootPosition:(CGPoint)rootPosition
{
    if(self = [super init])
    {
        _root = [CCNode node];
        [self addChild:_root];
        
        self.rootPosition = rootPosition;
        self.beginPage = 0;
        self.currentPage = 0;
        self.endPage = 0;
        self.userInteractionEnabled = YES;

    }
    return self;
}

-(void)setCurrentPage:(float)currentPage
{
    _currentPage = clampf(currentPage, self.beginPage, self.endPage);
    
    int pageless = (int)(_currentPage + 0.0);
    int pagemore = (int)(_currentPage + 1.0);
    
    
    float pagelesspercentage = 1.0 - (_currentPage - pageless);
    float pagemorepercentage = 1.0 - (pagemore - _currentPage);
    
    for (int i = 0; i <= self.endPage; i++)
    {
        VZInterimNode* node = [self ItemAtPage:i];
        node.opacity = 0;
        if(i == pageless)
        {
            node.opacity = pagelesspercentage;
        }
        
        if(i == pagemore)
        {
            node.opacity = pagemorepercentage;
        }
    }
    
}

-(void)setRootPosition:(CGPoint)rootPosition
{
    _rootPosition = rootPosition;
    _root.position = _rootPosition;
}

-(void)addItem:(VZInterimNode*)item AtPage:(int)page
{
    NSString* name = [NSString stringWithFormat:@"Page%d",page];
    [_root removeChildByName:name];
    [_root addChild:item z:page name:name];
}

-(VZInterimNode*)ItemAtPage:(int)page
{
    NSString* name = [NSString stringWithFormat:@"Page%d",page];
    return (VZInterimNode*)[_root getChildByName:name recursively:NO];
}


@end
