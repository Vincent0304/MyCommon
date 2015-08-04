//
//  VZWheelView.m
//  Untitled
//
//  Created by VincentZhang on 15/3/16.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZWheelView.h"
#import <objc/message.h>
#import "VZCommonDefine.h"
#define kVZWheelViewActionRotateTag 1


#pragma mark Helper classes

@interface VZWheelView (Helper)
- (void) updateVisibleSectors;
- (void) markVisibleSectorsDirty;
- (void) selectedSector:(NSUInteger) sector;
@end

@interface VZWheelViewCellHolder : NSObject

@property (nonatomic,strong) VZWheelViewCell* cell;

@end

@implementation VZWheelViewCellHolder
@end


@interface VZWheelViewContentNode : CCNodeColor
@end

@implementation VZWheelViewContentNode

- (void) setRotation:(float)rotation
{
    VZWheelView* wheelView = (VZWheelView*)self.parent;
    
    NSRange range = [wheelView.dataSource wheelViewValidRange:wheelView];
    
    
    VZCGFloatRange rotationRange;
    if ([wheelView.dataSource respondsToSelector:@selector(wheelView:angleForSectorAtIndex:)])
    {
        
        
        CGFloat location = 0;
        // Find start row
        for (NSUInteger currentSector = 0; currentSector < range.location; currentSector++)
        {
            if(currentSector != range.location - 1)
            {
                CGFloat sectorAngle = [wheelView.dataSource wheelView:wheelView angleForSectorAtIndex:currentSector];
                
                location += sectorAngle;
            }
            else
            {
                CGFloat sectorAngle = [wheelView.dataSource wheelView:wheelView angleForSectorAtIndex:currentSector];
                location += sectorAngle * 0.5;
            }
        }
        
        rotationRange.location = location;
        
        
        
    }
    else
    {
        rotationRange.location = range.location * wheelView.sectorAngle * 0.5;
        rotationRange.length = -(range.length * wheelView.sectorAngle);
       
    }
    
   
    rotation = clampf(rotation, rotationRange.location + rotationRange.length, rotationRange.location);
    
    [super setRotation:rotation];
    
    
    
    [wheelView markVisibleSectorsDirty];
    [wheelView updateVisibleSectors];
}

@end


#pragma mark VZWheelViewCell

@interface VZWheelViewCell (Helper)

@property (nonatomic,assign) NSUInteger index;

@end

@implementation VZWheelViewCell

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


#pragma mark VZWheelView




@implementation VZWheelView
{
    CGPoint     _lastPosition;
    CGFloat     _lastRotation;
}
- (id) init
{
    self = [super init];
    if (!self) return self;
    
    self.contentNode = [VZWheelViewContentNode nodeWithColor:[CCColor redColor]];
    self.contentNode.contentSize = CGSizeMake(0, 0);
    self.contentNode.anchorPoint = ccp(0.5, 0.5);
    [self addChild:self.contentNode];

    _sectorAngle = 60;
    _visibleAngle = VZCGFloatRangeMake(-90, 180);
    _visibleSectorsDirty = YES;
    _rotateFactor = 3.0;
    _state = VZWheelViewState_Normal;
    _sectorEnable = YES;
    
    
    self.userInteractionEnabled = YES;
    
    return self;
}

-(void)update:(CCTime)delta
{
    switch (_state)
    {
        case VZWheelViewState_Normal:
        {
            if(_sectorEnable == NO)
                return;
            CGFloat startSectorAngle = 0;
            if ([_dataSource respondsToSelector:@selector(wheelView:angleForSectorAtIndex:)])
            {
                NSRange range = [self visibleRangeForRotateAngle:self.contentNode.rotation];
                startSectorAngle = [self angleForCellWithIndex:range.location];
            }
            else
            {
                startSectorAngle = self.sectorAngle;
            }
            
            
            NSRange range = [self visibleRangeForRotateAngle:self.contentNode.rotation - startSectorAngle * 0.5];
            NSRange validRange = [_dataSource wheelViewValidRange:self];
            int startSector =  clampf((int)range.location, validRange.location - 1, NSMaxRange(validRange) - 1 - 1) ;
            
            float target = -startSector * self.sectorAngle;
            if(self.contentNode.rotation > target)
            {
                float delta = (self.contentNode.rotation - target) * 0.1;
                if(delta < 2)
                    delta = 2;
                
                self.contentNode.rotation -= delta;
                if(self.contentNode.rotation <= target)
                {
                    self.contentNode.rotation = target;
                    _state = VZWheelViewState_Oprated;
                    if ( [self.delegate respondsToSelector:@selector(wheelViewDidRotate:)] )
                    {
                        [self.delegate wheelViewDidRotate:self];
                    }
                }
            }
            else if(self.contentNode.rotation < target)
            {
                float delta = (target - self.contentNode.rotation) * 0.1;
                if(delta < 2)
                    delta = 2;
                
                self.contentNode.rotation += delta;
                if(self.contentNode.rotation >= target)
                {
                    self.contentNode.rotation = target;
                    _state = VZWheelViewState_Oprated;
                    if ( [self.delegate respondsToSelector:@selector(wheelViewDidRotate:)] )
                    {
                        [self.delegate wheelViewDidRotate:self];
                    }
                }
            }
            else
            {
                _state = VZWheelViewState_Oprated;
                if ( [self.delegate respondsToSelector:@selector(wheelViewDidRotate:)] )
                {
                    [self.delegate wheelViewDidRotate:self];
                }
            }
        }
            break;
        case VZWheelViewState_Oprated:
            
            break;
        default:
            break;
    }
}

-(void)setRotateFactor:(CGFloat)rotateFactor
{
    if(rotateFactor > 0)
    {
        _rotateFactor = rotateFactor;
    }
}

-(void)setVisibleAngle:(VZCGFloatRange)visibleAngle
{
    _visibleAngle = visibleAngle;
    [self markVisibleSectorsDirty];
    [self updateVisibleSectors];
}

-(CGFloat)rotateAngle
{
    return _contentNode.rotation;
}

-(void)setRotateAngle:(CGFloat)rotateAngle
{
    [self setRotateAngle:rotateAngle animated:NO];
}

- (void) setRotateAngle:(CGFloat)newAngle animated:(BOOL)animated
{
    
    
    // Check bounds
    if (animated)
    {
        CGFloat oldAngle = self.rotateAngle;
        float dist = newAngle - oldAngle;
        
        float duration = clampf(dist / 100, 0, 0.4);
        
        if (1)
        {
            // Animate horizontally
            
            // Create animation action
            CCActionInterval* action = [CCActionEaseOut actionWithAction:
                                        [CCActionRotateTo actionWithDuration:duration angle:newAngle] rate:2];
            action.tag = kVZWheelViewActionRotateTag;
            [_contentNode runAction:action];
        }
    }
    else
    {
        [_contentNode stopActionByTag:kVZWheelViewActionRotateTag];
        _contentNode.rotation = newAngle;
    }
}


- (NSRange) visibleRangeForRotateAngle:(CGFloat) rotateAngle
{
    
    if ([_dataSource respondsToSelector:@selector(wheelView:angleForSectorAtIndex:)])
    {
        // Rows may have different heights
        
        NSUInteger startSector = 0;
        CGFloat currentSectorAngle = 0;
        
        NSUInteger numSectors = [_dataSource wheelViewNumberOfSectors:self];
        
        // Find start row
        for (NSUInteger currentSector = 0; currentSector < numSectors; currentSector++)
        {
            // Increase row position
            CGFloat sectorAngle = [_dataSource wheelView:self angleForSectorAtIndex:currentSector];
            
            currentSectorAngle += sectorAngle;
            
            // Check if we are within visible range
            if (currentSectorAngle >= rotateAngle)
            {
                startSector = currentSector;
                break;
            }
        }
        
        // Find end row
        NSUInteger numVisibleSectors = 1;
        CGFloat wheelRadian = self.visibleAngle.length;
        for (NSUInteger currentSector = startSector; currentSector < numSectors; currentSector++)
        {
            // Check if we are out of visible range
            if (currentSectorAngle > rotateAngle + wheelRadian)
            {
                break;
            }
            
            // Increase row position
            CGFloat sectorAngle = [_dataSource wheelView:self angleForSectorAtIndex:currentSector + 1];
           
            currentSectorAngle += sectorAngle;
            
            numVisibleSectors ++;
        }
        
        // Handle potential edge case
        if ((startSector + numVisibleSectors) > numSectors) numVisibleSectors -= 1;
        
        return NSMakeRange(startSector, numVisibleSectors);
    }
    else
    {
        // All rows have the same height
        NSUInteger totalNumSectors = [_dataSource wheelViewNumberOfSectors:self];
        
        NSUInteger startSector = clampf(floorf(-rotateAngle/self.sectorAngle), 0, totalNumSectors -1);
        NSUInteger numVisibleSectors = floorf( self.visibleAngle.length / self.sectorAngle) + 1;
        
        // Make sure we are in range
        if (startSector + numVisibleSectors >= totalNumSectors)
        {
            numVisibleSectors = totalNumSectors - startSector;
        }
        
        return NSMakeRange(startSector, numVisibleSectors);
    }
}



- (CGFloat) angleForCellWithIndex:(NSUInteger)idx
{
    if (!_dataSource) return 0;
    
    CGFloat angle = (CGFloat)self.visibleAngle.location;
    
    if ([_dataSource respondsToSelector:@selector(wheelView:angleForSectorAtIndex:)])
    {
        angle += [_dataSource wheelView:self angleForSectorAtIndex:0] * 0.5;
        for (NSUInteger i = 0; i < idx; i++)
        {
            angle += [_dataSource wheelView:self angleForSectorAtIndex:i];
        }
    }
    else
    {
        angle += self.sectorAngle * 0.5;
        angle += idx * self.sectorAngle;
    }
    return angle;
}

- (void) showSectorsForRange:(NSRange)range
{
    if (NSEqualRanges(range, _currentlyVisibleRange)) return;
    
    for (NSUInteger oldIdx = _currentlyVisibleRange.location; oldIdx < NSMaxRange(_currentlyVisibleRange); oldIdx++)
    {
        if (!NSLocationInRange(oldIdx, range))
        {
            VZWheelViewCellHolder* holder = [_sectors objectAtIndex:oldIdx];
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
            VZWheelViewCellHolder* holder = [_sectors objectAtIndex:newIdx];
            if (!holder.cell)
            {
                holder.cell = [_dataSource wheelView:self nodeForSectorAtIndex:newIdx];
                holder.cell.index = newIdx;
                holder.cell.rotation =[self angleForCellWithIndex:newIdx];
                holder.cell.positionType = CCPositionTypeNormalized;
                holder.cell.position = ccp(0.5,0.5);
            }
            
            if (holder.cell)
            {
                [self.contentNode addChild:holder.cell z:holder.cell.index];
            }
        }
        else
        {
            VZWheelViewCellHolder* holder = [_sectors objectAtIndex:newIdx];
            if(holder)
            {
                holder.cell.rotation =[self angleForCellWithIndex:newIdx];
            }
        }
    }
    
    _currentlyVisibleRange = range;
}

- (void) markVisibleSectorsDirty
{
    _visibleSectorsDirty = YES;
}

- (void) updateVisibleSectors
{
    if (_visibleSectorsDirty)
    {
        [self showSectorsForRange:[self visibleRangeForRotateAngle:self.contentNode.rotation]];
        _visibleSectorsDirty = NO;
        
        if ( [self.delegate respondsToSelector:@selector(wheelViewDidUpdateVisibleSectors:)] )
        {
            [self.delegate wheelViewDidUpdateVisibleSectors:self];
        }
    }
}

- (void) reloadData
{
    _currentlyVisibleRange = NSMakeRange(0, 0);
    
    [self.contentNode removeAllChildrenWithCleanup:YES];
    
    if (!_dataSource) return;
    
    // Resize the content node
    NSUInteger numSectors = [_dataSource wheelViewNumberOfSectors:self];
    CGFloat wheelRadian = 0;
    
    if (_dataSourceFlags.angleForSectorAtIndex)
    {
        for (int i = 0; i < numSectors; i++)
        {
            wheelRadian += [_dataSource wheelView:self angleForSectorAtIndex:i];
        }
    }
    else
    {
        wheelRadian = numSectors * self.sectorAngle;
    }
    
    // Create empty placeholders for all rows
    _sectors = [NSMutableArray arrayWithCapacity:numSectors];
    for (int i = 0; i < numSectors; i++)
    {
        [_sectors addObject:[[VZWheelViewCellHolder alloc] init]];
    }
    
    // Update scroll position
    self.rotateAngle = self.rotateAngle;
    
    [self markVisibleSectorsDirty];
    [self updateVisibleSectors];
}

- (void) setDataSource:(id<VZWheelViewDataSource>)dataSource
{
    if (_dataSource != dataSource)
    {
        _dataSourceFlags.angleForSectorAtIndex = [dataSource respondsToSelector:@selector(wheelView:angleForSectorAtIndex:)];
        _dataSource = dataSource;
        [self reloadData];
    }
}

- (void) visit:(CCRenderer *)renderer parentTransform:(const GLKMatrix4 *)parentTransform
{
    [self updateVisibleSectors];
    [super visit:renderer parentTransform:parentTransform];
}

- (void) setSectorAngle:(CGFloat)sectorAngle
{
    if (_sectorAngle != sectorAngle)
    {
        _sectorAngle = sectorAngle;
        [self reloadData];
    }
}

- (void) setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    [self markVisibleSectorsDirty];
}

- (void) setContentSizeType:(CCSizeType)contentSizeType
{
    [super setContentSizeType:contentSizeType];
    [self markVisibleSectorsDirty];
}

- (void) onEnter
{
    [super onEnter];
    [self markVisibleSectorsDirty];
}


-(void)touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [touch locationInNode:self];
    _lastPosition = touchLoc;
    _lastRotation = self.contentNode.rotation;
    _state = VZWheelViewState_Oprated;
}

-(void)touchMoved:(CCTouch *)touch withEvent:(UIEvent *)event
{
    _state = VZWheelViewState_Oprated;
    CGPoint touchLoc = [touch locationInNode:self];
    float DeltaX = touchLoc.x - _lastPosition.x;
    
    float angle = _lastRotation + (DeltaX / self.contentSizeInPoints.width) * self.sectorAngle * self.rotateFactor;
    self.contentNode.rotation = angle;
}

-(void)touchEnded:(CCTouch *)touch withEvent:(UIEvent *)event
{
    _state = VZWheelViewState_Normal;
    CGPoint touchLoc = [touch locationInNode:self];
    
    if(ccpDistance(touchLoc, _lastPosition) < 5)
    {
        touchLoc = ccpSub(touchLoc, self.contentNode.positionInPoints);
        
        CGPoint startVector = ccp(cosf(VZDEGREES_TO_RADIANS(-self.visibleAngle.location + 90)), sinf(VZDEGREES_TO_RADIANS(-self.visibleAngle.location + 90)));
        
        CGFloat cosAngle = ccpDot(touchLoc, startVector) / ccpDistance(touchLoc, ccp(0,0)) * ccpDistance(startVector, ccp(0,0));
        CGFloat angle = VZRADIANS_TO_DEGREES(acosf(cosAngle));
        
        CGFloat crossMult = ccpCross(touchLoc, startVector);
        
        if(crossMult < 0)
        {
            angle = 360 - angle ;
        }
        
        angle = angle - self.contentNode.rotation;
        
        CCLOG(@"%f",angle);
        
        
        
        if ([_dataSource respondsToSelector:@selector(wheelView:angleForSectorAtIndex:)])
        {
            // Rows may have different heights
            CGFloat currentSectorAngle = 0;
            
            NSUInteger numSectors = [_dataSource wheelViewNumberOfSectors:self];
            
            // Find start row
            for (NSUInteger currentSector = 0; currentSector < numSectors; currentSector++)
            {
                // Increase row position
                CGFloat sectorAngle = [_dataSource wheelView:self angleForSectorAtIndex:currentSector];
                
                currentSectorAngle += sectorAngle;
                
                // Check if we are within visible range
                if (currentSectorAngle >= angle)
                {
                    [self selectedSector:currentSector];
                    break;
                }
            }
        }
        else
        {
            // All rows have the same height
            NSUInteger totalNumSectors = [_dataSource wheelViewNumberOfSectors:self];
            
            NSUInteger startSector = clampf(floorf(angle/self.sectorAngle), 0, totalNumSectors -1);
            [self selectedSector:startSector];
        }
    }
    
    if ( [self.delegate respondsToSelector:@selector(wheelViewWillBeginRotating:)] )
    {
        [self.delegate wheelViewWillBeginRotating:self];
    }
}

-(void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
   
}




#pragma mark Action handling

- (void) setTarget:(id)target selector:(SEL)selector
{
    __weak id weakTarget = target; // avoid retain cycle
    [self setBlock:^(id sender) {
        typedef void (*Func)(id, SEL, id);
        ((Func)objc_msgSend)(weakTarget, selector, sender);
    }];
}

- (void) selectedSector:(NSUInteger)sector
{
    self.selectedSector = sector;
    [self triggerAction];
}

- (void) triggerAction
{
    if (self.userInteractionEnabled && _block)
    {
        _block(self);
    }
}




@end
