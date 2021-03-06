//
//  VZSoundSwitch.m
//  Mahjong
//
//  Created by 穆暮 on 14-6-12.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "VZSoundSwitch.h"
#import "VZAudioManager.h"
@implementation VZSoundSwitch

-(id)initWithTitle:(NSString *)title spriteFrame:(CCSpriteFrame *)spriteFrame highlightedSpriteFrame:(CCSpriteFrame *)highlighted disabledSpriteFrame:(CCSpriteFrame *)disabled
{
    if(self = [super initWithTitle:title spriteFrame:spriteFrame highlightedSpriteFrame:highlighted disabledSpriteFrame:disabled])
    {
        [self setBackgroundColor:[CCColor colorWithWhite:0.7 alpha:1] forState:CCControlStateDisabled];
        [self setLabelColor:[CCColor colorWithWhite:0.7 alpha:1] forState:CCControlStateDisabled];
        
        [self setBackgroundOpacity:0.7f forState:CCControlStateHighlighted];
        [self setLabelOpacity:0.7f forState:CCControlStateHighlighted];
        
        if([[VZAudioManager sharedVZAudioManager] isSoundEnable])
        {
            self.selected = YES;
        }
        else
        {
            self.selected = NO;
        }
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if(selected)
    {
        [VZAudioManager sharedVZAudioManager].sound = 1.0;
    }
    else
    {
        [VZAudioManager sharedVZAudioManager].sound = 0.0;
    }
}

@end
