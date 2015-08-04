//
//  VZLoopTexture.h
//  Untitled
//
//  Created by VincentZhang on 15/3/23.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCActionInterval.h"

@interface VZLoopTextureForSprite : CCActionInterval
{
    CGPoint _positionDelta;
    CGPoint _startPos;
    CGPoint _previousPos;
}

+ (id)actionWithDuration: (CCTime)duration Velocity:(CGPoint)velocity;

@end
