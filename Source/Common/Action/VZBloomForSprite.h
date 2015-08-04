//
//  VZBloomForSprite.h
//  Pirate
//
//  Created by VincentZhang on 15/5/13.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCActionInterval.h"

@interface VZBloomForSprite : CCActionInterval <NSCopying>
{
    float _radiusDelta;
    float _startRadius;
    float _previousRadius;
    float _radius;
    
    float _intensityDelta;
    float _startIntensity;
    float _previousIntensity;
    float _intensity;
    
    float _thresholdDelta;
    float _startThreshold;
    float _previousThreshold;
    float _threshold;
}

+ (VZBloomForSprite*)actionWithDuration:(CCTime)duration Radius:(float)radius Intensity:(float)intensity Threshold:(float)threshold;
- (id)initWithDuration:(CCTime)duration Radius:(float)radius Intensity:(float)intensity Threshold:(float)threshold;
@end
