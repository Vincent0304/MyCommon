//
//  VZCrossFadeView.m
//  Untitled
//
//  Created by VincentZhang on 15/3/24.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZCrossFadeView.h"
#import <objc/message.h>
#import "VZCommonDefine.h"
#define kVZWheelViewActionRotateTag 1


#pragma mark Helper classes

@interface VZCrossFadeView (Helper)
- (void) updateVisiblePages;
- (void) markVisiblePagesDirty;
- (void) selectedSector:(NSUInteger) sector;
@end

@interface VZCrossFadeViewCellHolder : NSObject

@property (nonatomic,strong) VZCrossFadeViewCell* cell;

@end

@implementation VZCrossFadeViewCellHolder
@end


@interface VZCrossFadeViewContentNode : CCNodeColor
@end

@implementation VZCrossFadeViewContentNode

- (void) setRotation:(float)rotation
{
    [super setRotation:rotation];
    
    VZCrossFadeView* fadeView = (VZCrossFadeView*)self.parent;
    [fadeView markVisiblePagesDirty];
    [fadeView updateVisiblePages];
}

@end


#pragma mark VZWheelViewCell

@interface VZCrossFadeViewCell (Helper)

@property (nonatomic,assign) NSUInteger index;

@end

@implementation VZCrossFadeViewCell

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    return self;
}

- (void) setIndex:(NSUInteger)index
{
    _index = index;
}

- (NSUInteger) index
{
    return _index;
}

@end


#pragma mark VZCrossFadeView

@implementation VZCrossFadeView
{

}
- (id) init
{
    self = [super init];
    if (!self) return self;
    
    self.contentNode = [VZCrossFadeViewContentNode nodeWithColor:[CCColor redColor]];
    self.contentNode.contentSize = CGSizeMake(0, 0);
    self.contentNode.anchorPoint = ccp(0.5, 0.5);
    self.contentNode.positionType = CCPositionTypeNormalized;
    self.contentNode.position = ccp(0.5, 0.5);
    [self addChild:self.contentNode];
    

    _visiblePageRange = NSMakeRange(0, 1);
    _visiblePagesDirty = YES;

    return self;
}



-(void)setCurrentPage:(CGFloat)currentPage
{
    _currentPage = clampf(currentPage, self.visiblePageRange.location, NSMaxRange(self.visiblePageRange) - 1);
    [self markVisiblePagesDirty];
    [self updateVisiblePages];

}

-(void)setVisiblePageRange:(NSRange)visiblePage
{
    _visiblePageRange = visiblePage;
    [self markVisiblePagesDirty];
    [self updateVisiblePages];
}

- (NSRange) visibleRangeForPage:(CGFloat) Page
{
    // All rows have the same height
    NSUInteger totalNumPages = [_dataSource crossFadeViewNumberOfPages:self];
    
    NSUInteger startPage = clampf(floorf(Page), 0, totalNumPages -1);
    NSUInteger numVisiblePages = floorf(self.visiblePageRange.length) + 1;
    
    // Make sure we are in range
    if (startPage + numVisiblePages >= totalNumPages)
    {
        numVisiblePages = totalNumPages - startPage;
    }
    
    return NSMakeRange(startPage, numVisiblePages);
}

- (CGFloat) opacityForCellWithIndex:(NSUInteger)idx
{
    if (!_dataSource) return 0;
    
    CGFloat opacity = 1.0;
    if(_currentPage > idx)
    {
        opacity = 1.0 - (_currentPage - idx);
    }
    else
    {
        opacity = 1.0 + (_currentPage - idx);
    }
    return opacity;
}

- (void) showPagesForRange:(NSRange)range
{

    for (NSUInteger oldIdx = _currentlyVisibleRange.location; oldIdx < NSMaxRange(_currentlyVisibleRange); oldIdx++)
    {
        if (!NSLocationInRange(oldIdx, range))
        {
            VZCrossFadeViewCellHolder* holder = [_pages objectAtIndex:oldIdx];
            if (holder)
            {
                [self.contentNode removeChild:holder.cell cleanup:YES];
                holder.cell = NULL;
            }
        }
    }
    
    for (NSUInteger newIdx = range.location; newIdx < NSMaxRange(range); newIdx++)
    {
        if (!NSLocationInRange(newIdx, _currentlyVisibleRange))
        {
            VZCrossFadeViewCellHolder* holder = [_pages objectAtIndex:newIdx];
            if (!holder.cell)
            {
                holder.cell = [_dataSource crossFadeView:self nodeForPageAtIndex:newIdx];
                holder.cell.index = newIdx;
                holder.cell.opacity =[self opacityForCellWithIndex:newIdx];
                holder.cell.positionType = CCPositionTypeNormalized;
                holder.cell.position = ccp(0.5,0.5);
            }
            
            if (holder.cell)
            {
                [self.contentNode addChild:holder.cell];
            }
        }
        else
        {
            VZCrossFadeViewCellHolder* holder = [_pages objectAtIndex:newIdx];
            if(holder)
            {
                holder.cell.opacity =[self opacityForCellWithIndex:newIdx];
            }
        }
    }
    
    _currentlyVisibleRange = range;
}

- (void) markVisiblePagesDirty
{
    _visiblePagesDirty = YES;
}

- (void) updateVisiblePages
{
    if (_visiblePagesDirty)
    {
        [self showPagesForRange:[self visibleRangeForPage:self.currentPage]];
        _visiblePagesDirty = NO;
    }
}

- (void) reloadData
{
    _currentlyVisibleRange = NSMakeRange(0, 0);
    
    [self.contentNode removeAllChildrenWithCleanup:YES];
    
    if (!_dataSource) return;
    
    // Resize the content node
    NSUInteger numPages = [_dataSource crossFadeViewNumberOfPages:self];

    // Create empty placeholders for all rows
    _pages = [NSMutableArray arrayWithCapacity:numPages];
    for (int i = 0; i < numPages; i++)
    {
        [_pages addObject:[[VZCrossFadeViewCellHolder alloc] init]];
    }
    
    // Update scroll position
    self.currentPage = self.currentPage;
    
    [self markVisiblePagesDirty];
    [self updateVisiblePages];
}

- (void) setDataSource:(id<VZCrossFadeViewDataSource>)dataSource
{
    if (_dataSource != dataSource)
    {
        _dataSource = dataSource;
        [self reloadData];
    }
}

- (void) visit:(CCRenderer *)renderer parentTransform:(const GLKMatrix4 *)parentTransform
{
    [self updateVisiblePages];
    [super visit:renderer parentTransform:parentTransform];
}

- (void) onEnter
{
    [super onEnter];
    [self markVisiblePagesDirty];
}

@end
