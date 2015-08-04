//
//  VZCircleMove.h
//  Connect Four
//
//  Created by 穆暮 on 14-10-11.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "CCActionInterval.h"

@interface VZCircleMove : CCActionInterval
{
    CGPoint _orgin;
    float   _radius;
    float   _start;
    float   _end;
    BOOL    _rotate;
}

+ (id)actionWithDuration: (CCTime)duration Origin:(CGPoint)origin Radius:(float)radius StartAngle:(float)start_angel EndAngle:(float)end_angle Rotate:(BOOL)rotate;

@end
