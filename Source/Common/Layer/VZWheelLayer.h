//
//  VZWheelLayer.h
//  One Day In The Zoo
//
//  Created by 穆暮 on 14-10-18.
//  Copyright 2014年 穆暮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "VZWheelItem.h"
typedef enum
{
    VZWheelState_Normal = 0,
    VZWheelState_Oprated,
}VZWheelState;

@interface VZWheelLayer : CCNodeColor
{
    CCNode*         _axes;
    VZWheelState    _state;
    
    BOOL            _selfFixed;
    
    BOOL            _isTap;
    
    float           _maxDragDistance;
}

@property (nonatomic, assign)CGPoint axesPosition;
@property (nonatomic, assign)float angleDelta;
@property (nonatomic, assign)float currentAngle;
@property (nonatomic, assign)int   beginPage;
@property (nonatomic, assign)int   currentPage;
@property (nonatomic, assign)int   endPage;

@property (nonatomic, readonly)CGPoint touchBegin;
@property (nonatomic, readonly)float angleBegin;
@property (nonatomic, readonly)int pageBegin;

@property (nonatomic, assign)float pageDeltaOneScreen;

+(VZWheelLayer*)wheelLayerWithAxesPosition:(CGPoint)axesPosition AngleDelta:(float)angleDelta;

-(id)initWithAxesPosition:(CGPoint)axesPosition AngleDelta:(float)angleDelta;

-(void)addItem:(VZWheelItem*)item AtPage:(int)page;
-(VZWheelItem*)ItemAtPage:(int)page;

-(void)enterCurrentPage;

-(void)tapCurrentPage;

@end
