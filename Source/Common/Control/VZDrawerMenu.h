//
//  DrawerMenu.h
//  One Day In The Zoo
//
//  Created by 穆暮 on 14-10-22.
//  Copyright (c) 2014年 穆暮. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d-ui.h"
#import "VZSwitch.h"
@interface VZDrawerMenu : CCNode
{
    NSMutableArray* _buttons;
}

@property (nonatomic, strong)CCButton* drawer;
@property (nonatomic, assign)CGSize buttonSize;

+(VZDrawerMenu*)drawerMenuWithDrawer:(CCButton*)drawer Buttons:(NSArray*)buttons;

@end
