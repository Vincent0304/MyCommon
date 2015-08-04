//
//  VZBrightForSprite.m
//  Pirate
//
//  Created by VincentZhang on 15/5/13.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZBrightForSprite.h"

@implementation VZBrightForSprite
+(VZBrightForSprite *)actionWithDuration:(CCTime)duration Brightness:(float)brightness
{
    return [[self alloc] initWithDuration:duration Brightness:brightness];
}

-(id)initWithDuration:(CCTime)duration Brightness:(float)brightness
{
    if( (self=[super initWithDuration:duration] ) )
    {
        _brightness = brightness;
    }
    return self;
}

-(id) copyWithZone: (NSZone*) zone
{
    CCAction *copy = [(VZBrightForSprite*)[[self class] allocWithZone: zone] initWithDuration:_duration Brightness:_brightness];
    return copy;
}

-(void) startWithTarget:(CCNode*)aTarget
{
    [super startWithTarget:aTarget];
    
    CCSprite* tn = (CCSprite*) _target;
    CCEffectBrightness* effect = (CCEffectBrightness*)tn.effect;
    _brightnessDelta = _brightness - effect.brightness;
    _startBrightness =  effect.brightness;
    _previousBrightness = effect.brightness;
}

-(void) update: (CCTime) t
{
    CCSprite* tn = (CCSprite*) _target;
    CCEffectBrightness* effect = (CCEffectBrightness*)tn.effect;
    
    float currentBrightness = effect.brightness;
    float diffBrightness = currentBrightness - _previousBrightness;
    _startBrightness = _startBrightness + diffBrightness;
    float newBrightness = _startBrightness + _brightnessDelta * t;
    effect.brightness = newBrightness;
    _previousBrightness = newBrightness;
    
}

@end
