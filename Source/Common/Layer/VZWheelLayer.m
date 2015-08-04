//
//  VZWheelLayer.m
//  One Day In The Zoo
//
//  Created by 穆暮 on 14-10-18.
//  Copyright 2014年 穆暮. All rights reserved.
//

#import "VZWheelLayer.h"


@implementation VZWheelLayer

+(VZWheelLayer *)wheelLayerWithAxesPosition:(CGPoint)axesPosition AngleDelta:(float)angleDelta
{
    return [[self alloc] initWithAxesPosition:axesPosition AngleDelta:angleDelta];
}

-(id)initWithAxesPosition:(CGPoint)axesPosition AngleDelta:(float)angleDelta
{
    if(self = [super init])
    {
        _axes = [CCNode node];
        [self addChild:_axes];
        
        self.axesPosition = axesPosition;
        
        self.angleDelta = angleDelta;
        
        self.currentAngle = 0;
        
        self.beginPage = 0;
        self.currentPage = 0;
        self.endPage = 0;
        
        self.userInteractionEnabled = YES;
        
        _state = VZWheelState_Normal;
        
        self.pageDeltaOneScreen = 3.0;
        
        _pageBegin = -1;
    }
    return self;
}

-(void)dealloc
{
   
}

-(void)setAxesPosition:(CGPoint)axesPosition
{
    _axesPosition = axesPosition;
    _axes.position = _axesPosition;
}

-(void)setCurrentAngle:(float)currentAngle
{
    if(currentAngle > self.angleDelta * (self.beginPage + 0.5))
        currentAngle = self.angleDelta * (self.beginPage + 0.5);
    
    if(currentAngle < -self.angleDelta * (self.endPage + 0.5))
        currentAngle = -self.angleDelta * (self.endPage + 0.5);
    
    _currentAngle = currentAngle;
    _axes.rotation = currentAngle;
    
    int page = (int)((-_currentAngle - (-self.angleDelta * 0.5)) / self.angleDelta);
    self.currentPage = page;
}

-(void)setCurrentPage:(int)currentPage
{
    if(currentPage < self.beginPage)
        currentPage = self.beginPage;
    
    if (currentPage > self.endPage)
        currentPage = self.endPage;
    
    _currentPage = currentPage;
    
    for (CCNode* node in _axes.children)
    {
        node.visible = NO;
    }
    
    for (int i = -1; i < 2; i++)
    {
        NSString* name = [NSString stringWithFormat:@"Page%d",_currentPage + i];
        CCNode* node = [_axes getChildByName:name recursively:NO];
        if(node)
            node.visible = YES;
    }
}

-(void)enterCurrentPage
{
    if(self.pageBegin != self.currentPage)
    {
        VZWheelItem* item = [self ItemAtPage:self.currentPage];
        [item enter];
    }
    
    
}


-(void)update:(CCTime)delta
{
    switch (_state)
    {
        case VZWheelState_Normal:
        {
            float target = -self.currentPage * self.angleDelta;
            if(self.currentAngle > target)
            {
                float delta = (self.currentAngle - target) * 0.1;
                if(delta < 2)
                    delta = 2;
                
                self.currentAngle -= delta;
                if(self.currentAngle <= target)
                {
                    self.currentAngle = target;
                    if(!_selfFixed)
                    {
                        [self enterCurrentPage];
                        _selfFixed = YES;
                    }
                }
            }
            else if(self.currentAngle < target)
            {
                float delta = (target - self.currentAngle) * 0.1;
                if(delta < 2)
                    delta = 2;
                
                self.currentAngle += delta;
                if(self.currentAngle >= target)
                {
                    self.currentAngle = target;
                    
                    if(!_selfFixed)
                    {
                        [self enterCurrentPage];
                        _selfFixed = YES;
                    }
                    
                }
            }
            else
            {
                if(!_selfFixed)
                {
                    [self enterCurrentPage];
                    _selfFixed = YES;
                }
            }
        }
            break;
        case VZWheelState_Oprated:
            
            break;
        default:
            break;
    }
}

-(void)addItem:(VZWheelItem*)item AtPage:(int)page
{
    float angle = page * self.angleDelta;
    item.rotation = angle;
    
    NSString* name = [NSString stringWithFormat:@"Page%d",page];
    [_axes removeChildByName:name];
    [_axes addChild:item z:page name:name];
    
    self.currentAngle = self.currentAngle;
}

-(VZWheelItem*)ItemAtPage:(int)page
{
    NSString* name = [NSString stringWithFormat:@"Page%d",page];
    return (VZWheelItem*)[_axes getChildByName:name recursively:NO];
}

-(void)tapCurrentPage
{
    
}

-(void)touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [touch locationInNode:self];
    _touchBegin = touchLoc;
    _angleBegin = self.currentAngle;
    _pageBegin = self.currentPage;
    _state = VZWheelState_Oprated;
  
    _maxDragDistance = 0;
}

-(void)touchMoved:(CCTouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [touch locationInNode:self];
    float DeltaX = touchLoc.x - _touchBegin.x;
    
    _maxDragDistance = MAX(_maxDragDistance, ccpDistance(_touchBegin, touchLoc)) ;
    
    float angle = _angleBegin + (DeltaX / self.contentSize.width) * self.angleDelta * self.pageDeltaOneScreen;
    self.currentAngle = angle;
    
    _state = VZWheelState_Oprated;

}

-(void)touchEnded:(CCTouch *)touch withEvent:(UIEvent *)event
{
    _selfFixed = NO;
    _state = VZWheelState_Normal;
    
    if(_maxDragDistance < 5)
    {
        
        CGPoint p = [touch locationInNode:self];
        CGRect rect = CGRectMake(self.contentSize.width * 0.1, self.contentSize.height * 0.0, self.contentSize.width * 0.8, self.contentSize.height * 0.75);
        
        if(CGRectContainsPoint(rect, p))
        {
            [self tapCurrentPage];
        }
        
        
    }
    
    
}

-(void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self touchEnded:touch withEvent:event];
}
@end
