//
//  VZBrightForSprite.h
//  Pirate
//
//  Created by VincentZhang on 15/5/13.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCActionInterval.h"

@interface VZBrightForSprite : CCActionInterval <NSCopying>
{
    float _brightnessDelta;
    float _startBrightness;
    float _previousBrightness;
    float _brightness;
}

+ (VZBrightForSprite*)actionWithDuration:(CCTime)duration Brightness:(float)brightness;
- (id)initWithDuration:(CCTime)duration Brightness:(float)brightness;

@end
