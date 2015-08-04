//
//  VZCrossFadeView.h
//  Untitled
//
//  Created by VincentZhang on 15/3/24.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCNode.h"



@class CCButton;
@class VZCrossFadeView;


#pragma mark VZCrossFadeViewCell

@interface VZCrossFadeViewCell : CCNode
{
    NSUInteger _index;
}
@end

#pragma mark VZCrossFadeViewDataSource

@protocol VZCrossFadeViewDataSource <NSObject>

- (VZCrossFadeViewCell*) crossFadeView:(VZCrossFadeView*)fadeView nodeForPageAtIndex:(NSUInteger) index;
- (NSUInteger) crossFadeViewNumberOfPages:(VZCrossFadeView*) fadeView;

@end

#pragma mark VZCrossFadeView

@protocol VZCrossFadeViewDelegate <NSObject>

@optional
- (void)crossFadeViewDidFade:(VZCrossFadeView *)fadeView;
- (void)CrossFadeViewWillBeginFade:(VZCrossFadeView *)fadeView;
@end


@interface VZCrossFadeView : CCNode
{
    BOOL _visiblePagesDirty;
    NSMutableArray* _pages;
    NSRange _currentlyVisibleRange;
}
@property (nonatomic, weak) id<VZCrossFadeViewDelegate> delegate;

@property (nonatomic,assign) CGFloat currentPage;
@property (nonatomic,assign) NSRange visiblePageRange;
@property (nonatomic,strong) CCNode* contentNode;
@property (nonatomic,strong) id <VZCrossFadeViewDataSource> dataSource;
@property (nonatomic,assign) NSUInteger selectedPage;

- (void) reloadData;
@end
