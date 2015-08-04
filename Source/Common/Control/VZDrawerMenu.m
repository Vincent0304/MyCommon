//
//  DrawerMenu.m
//  One Day In The Zoo
//
//  Created by 穆暮 on 14-10-22.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "VZDrawerMenu.h"

@implementation VZDrawerMenu

+(VZDrawerMenu*)drawerMenuWithDrawer:(CCButton*)drawer Buttons:(NSArray*)buttons
{
    return [[self alloc] initWithDrawer:drawer Buttons:buttons];
}

-(id)initWithDrawer:(CCButton*)drawer Buttons:(NSArray*)buttons
{
    if (self = [super init])
    {
        _buttons = [NSMutableArray arrayWithCapacity:buttons.count];
        
        self.buttonSize = CGSizeMake(0, 0);
       
        
        
        for (CCButton* button in buttons)
        {
            [_buttons addObject:button];
            [self addChild:button];
        }
        
        self.drawer = drawer;
        self.drawer.position = ccp(0, 0);
        [self.drawer setTarget:self selector:@selector(switchDrawer:)];
        [self addChild:drawer];
        
        [self setDrawerOpen:NO Animated:NO];
    }
    return self;
}

-(void)setDrawerOpen:(BOOL)isOpen Animated:(BOOL)animated
{
    if(!animated)
    {
        int i = 1;
        for (CCButton* button in _buttons)
        {
            
            [button stopActionByTag:1];
            button.visible = isOpen;
            button.opacity = 1.0;
            if(button.visible)
                button.position = ccp(self.drawer.position.x + self.buttonSize.width * i,
                                      self.drawer.position.y + self.buttonSize.height * i);
            else
                button.position = self.drawer.position;
            
            i++;
        }
    }
    else
    {
        int i = 1;
        for (CCButton* button in _buttons)
        {
            if(isOpen)
            {
                CGPoint target = ccp(self.drawer.position.x + self.buttonSize.width * (_buttons.count - i + 1),
                                     self.drawer.position.y + self.buttonSize.height * (_buttons.count - i + 1));
                
                float showDelay = (i - 1) * 0.25;
                float moveDuration = (_buttons.count - i + 1) * 0.25;
                
                CCActionSequence* sequence = [CCActionSequence actions:
                                              [CCActionDelay actionWithDuration:showDelay],
                                              [CCActionCallBlock actionWithBlock:^{
                                                button.visible = isOpen;
                                                button.opacity = 1.0;
                                                }],
                                              [CCActionEaseOut actionWithAction:[CCActionMoveTo actionWithDuration:moveDuration position:target] rate:1.5],
                                              nil];
                sequence.tag = 1;
                [button stopActionByTag:1];
                [button runAction:sequence];
                
            }
            else
            {
                CGPoint target = self.drawer.position;
                
                float moveDuration = (_buttons.count - i + 1) * 0.25;
                
                CCActionSequence* sequence = [CCActionSequence actions:
                                            [CCActionEaseOut actionWithAction:[CCActionMoveTo actionWithDuration:moveDuration position:target] rate:1.5],
                                              [CCActionFadeOut actionWithDuration:0.2],
                                              nil];
                sequence.tag = 1;
                [button stopActionByTag:1];
                [button runAction:sequence];
            }
            
            i++;
            
        }
    }
    
    
}

-(void)switchDrawer:(id)sender
{
    [self setDrawerOpen:self.drawer.selected Animated:YES];
}

@end
