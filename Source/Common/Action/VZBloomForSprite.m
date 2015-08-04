//
//  VZBloomForSprite.m
//  Pirate
//
//  Created by VincentZhang on 15/5/13.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZBloomForSprite.h"


@implementation VZBloomForSprite

+(VZBloomForSprite*)actionWithDuration:(CCTime)duration Radius:(float)radius Intensity:(float)intensity Threshold:(float)threshold
{
    return [[self alloc] initWithDuration:duration Radius:radius Intensity:intensity Threshold:threshold];
}

-(id)initWithDuration:(CCTime)duration Radius:(float)radius Intensity:(float)intensity Threshold:(float)threshold
{
    if( (self=[super initWithDuration:duration] ) )
    {
        _radius = radius;
        _intensity = intensity;
        _threshold = threshold;
    }
    return self;
}

-(id) copyWithZone: (NSZone*) zone
{
    CCAction *copy = [(VZBloomForSprite*)[[self class] allocWithZone: zone] initWithDuration:_duration Radius:_radius Intensity:_intensity Threshold:_threshold];
    return copy;
}

-(void) startWithTarget:(CCNode*)aTarget
{
    [super startWithTarget:aTarget];
    
    CCSprite* tn = (CCSprite*) _target;
    CCEffectBloom* effect = (CCEffectBloom*)tn.effect;
    _radiusDelta = _radius - effect.blurRadius;
    _startRadius = effect.blurRadius;
    _previousRadius = effect.blurRadius;
    
    _intensityDelta = _intensity - effect.intensity;
    _startIntensity = effect.intensity;
    _previousIntensity = effect.intensity;
    
    _threshold = _threshold - effect.luminanceThreshold;
    _startThreshold = effect.luminanceThreshold;
    _previousThreshold = effect.luminanceThreshold;
    
    
}

-(void) update: (CCTime) t
{
    CCSprite* tn = (CCSprite*) _target;
    CCEffectBloom* effect = (CCEffectBloom*)tn.effect;
    
    float currentRadius = effect.blurRadius;
    float diffRadius = currentRadius - _previousRadius;
    _startRadius = _startRadius + diffRadius;
    float newRadius = _startRadius + _radiusDelta * t;
    effect.blurRadius = newRadius;
    _previousRadius = newRadius;
    
    
    float currentIntensity = effect.intensity;
    float diffIntensity = currentIntensity - _previousIntensity;
    _startIntensity = _startIntensity + diffIntensity;
    float newIntensity = _startIntensity + _intensityDelta * t;
    effect.intensity = newIntensity;
    _previousIntensity = newIntensity;
    
    
    float currentThreshold = effect.luminanceThreshold;
    float diffThreshold = currentThreshold - _previousThreshold;
    _startThreshold = _startThreshold + diffThreshold;
    float newThreshold = _startThreshold + _thresholdDelta * t;
    effect.luminanceThreshold = newThreshold;
    _previousThreshold = newThreshold;
}

@end
