//
//  VZInterimLayer.h
//  One Day In The Zoo
//
//  Created by 穆暮 on 14-11-3.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "CCNodeColor.h"
#import "VZInterimNode.h"
@interface VZInterimLayer : CCNodeColor
{
    CCNode*         _root;
}

@property (nonatomic, assign)CGPoint rootPosition;

@property (nonatomic, assign)int   beginPage;
@property (nonatomic, assign)float currentPage;
@property (nonatomic, assign)int   endPage;

+(VZInterimLayer*)interimLayerWithRootPosition:(CGPoint)rootPosition;

-(id)initWithRootPosition:(CGPoint)rootPosition;


-(void)addItem:(VZInterimNode*)item AtPage:(int)page;
-(VZInterimNode*)ItemAtPage:(int)page;

@end
