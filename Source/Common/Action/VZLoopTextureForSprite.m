//
//  VZLoopTexture.m
//  Untitled
//
//  Created by VincentZhang on 15/3/23.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "VZLoopTextureForSprite.h"
#import "CCSprite.h"
#import "CCTexture_Private.h"
#import "VZCommonDefine.h"

@implementation VZLoopTextureForSprite

+ (id)actionWithDuration: (CCTime)duration Velocity:(CGPoint)velocity
{
    return [[self alloc] initWithDuration:duration Velocity:velocity];
}

-(id) initWithDuration: (CCTime)duration Velocity:(CGPoint)velocity
{
    if( (self=[super initWithDuration: duration]) )
        _positionDelta = velocity;
    return self;
}

-(id) copyWithZone: (NSZone*) zone
{
    return [[[self class] allocWithZone: zone] initWithDuration:[self duration] position:_positionDelta];
}

-(void) startWithTarget:(CCNode *)target
{
    [super startWithTarget:target];
    
    CCSprite* tn = (CCSprite*) _target;
    
    ccTexParams params = {GL_NEAREST,GL_NEAREST,GL_CLAMP_TO_EDGE,GL_CLAMP_TO_EDGE};
    
    params.minFilter = VZIS_POWER_OF_TWO((NSUInteger)tn.textureRect.size.width) ? GL_LINEAR : GL_NEAREST;
    params.magFilter = VZIS_POWER_OF_TWO((NSUInteger)tn.textureRect.size.height) ? GL_LINEAR : GL_NEAREST;
    params.wrapS = VZIS_POWER_OF_TWO((NSUInteger)tn.textureRect.size.width) ? GL_REPEAT : GL_CLAMP_TO_EDGE;
    params.wrapT = VZIS_POWER_OF_TWO((NSUInteger)tn.textureRect.size.height) ? GL_REPEAT : GL_CLAMP_TO_EDGE;

    [tn.texture setTexParameters:&params];
    
    _previousPos = _startPos = tn.textureRect.origin;
}

-(CCActionInterval*) reverse
{
    return [[self class] actionWithDuration:_duration position:ccp( -_positionDelta.x, -_positionDelta.y)];
}

-(void) update: (CCTime) t
{
    
    CCSprite *node = (CCSprite*)_target;
    
#if CC_ENABLE_STACKABLE_ACTIONS
    CGPoint currentPos = node.textureRect.origin;
    CGPoint diff = ccpSub(currentPos, _previousPos);
    _startPos = ccpAdd( _startPos, diff);
    CGPoint newPos =  ccpAdd( _startPos, ccpMult(_positionDelta, t) );
    node.textureRect = CGRectMake(newPos.x, newPos.y, node.textureRect.size.width, node.textureRect.size.height);
    _previousPos = newPos;
#else
    [node setSourcePosition: ccpAdd( _startPos, ccpMult(_positionDelta, t))];
#endif // CC_ENABLE_STACKABLE_ACTIONS
}


@end
