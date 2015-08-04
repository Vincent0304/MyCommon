//
//  VZWheelView.h
//  Untitled
//
//  Created by VincentZhang on 15/3/16.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCNode.h"

@class CCButton;
@class VZWheelView;

typedef struct _VZCGFloatRange
{
    CGFloat location;
    CGFloat length;
} VZCGFloatRange;

NS_INLINE VZCGFloatRange VZCGFloatRangeMake(CGFloat loc, CGFloat len) {
    VZCGFloatRange r;
    r.location = loc;
    r.length = len;
    return r;
}

#pragma mark VZWheelViewCell

@interface VZWheelViewCell : CCNode
{
    NSUInteger _index;
}


@end

#pragma mark VZWheelViewDataSource

@protocol VZWheelViewDataSource <NSObject>

- (VZWheelViewCell*) wheelView:(VZWheelView*)wheelView nodeForSectorAtIndex:(NSUInteger) index;
- (NSUInteger) wheelViewNumberOfSectors:(VZWheelView*) wheelView;
- (NSRange) wheelViewValidRange:(VZWheelView*)wheelView;

@optional

- (float) wheelView:(VZWheelView*)wheelView angleForSectorAtIndex:(NSUInteger) index;

@end

#pragma mark VZWheelView

@protocol VZWheelViewDelegate <NSObject>

@optional
- (void)wheelViewDidRotate:(VZWheelView *)wheelView;
- (void)wheelViewWillBeginRotating:(VZWheelView *)wheelView;
- (void)wheelViewDidUpdateVisibleSectors:(VZWheelView *)wheelView;
@end

typedef enum
{
    VZWheelViewState_Normal = 0,
    VZWheelViewState_Oprated,
}VZWheelViewState;

@interface VZWheelView : CCNode
{
    
    VZWheelViewState _state;
    BOOL _visibleSectorsDirty;
    NSMutableArray* _sectors;
    NSRange _currentlyVisibleRange;
    struct {
        int angleForSectorAtIndex:1;
        // reserved for future dataSource delegation
    } _dataSourceFlags;
}
@property (nonatomic, weak) id<VZWheelViewDelegate> delegate;

@property (nonatomic,assign) VZCGFloatRange visibleAngle;
@property (nonatomic,strong) CCNode* contentNode;
@property (nonatomic,strong) id <VZWheelViewDataSource> dataSource;
@property (nonatomic,assign) CGFloat sectorAngle;
@property (nonatomic,assign) NSUInteger selectedSector;
@property (nonatomic,assign) CGFloat rotateAngle;
@property (nonatomic,assign) CGFloat rotateFactor;
@property (nonatomic,assign) BOOL sectorEnable;

@property (nonatomic,copy) void(^block)(id sender);
-(void) setTarget:(id)target selector:(SEL)selector;

- (void) reloadData;

@end
